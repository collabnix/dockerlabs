# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)      default(""), not null
#  email                  :string(255)      default("")
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default("0")
#  enabled                :boolean          default("1")
#  ldap_name              :string(255)
#  failed_attempts        :integer          default("0")
#  locked_at              :datetime
#  display_name           :string(255)
#  namespace_id           :integer
#
# Indexes
#
#  index_users_on_display_name          (display_name) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_namespace_id          (namespace_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

class User < ActiveRecord::Base
  include PublicActivity::Common

  enabled_devise_modules = [:database_authenticatable, :registerable, :lockable,
                            :recoverable, :rememberable, :trackable, :validatable,
                            authentication_keys: [:username]]

  enabled_devise_modules.delete(:validatable) if Portus::LDAP.enabled?
  devise(*enabled_devise_modules)

  APPLICATION_TOKENS_MAX = 5

  # Actions performed before/after create.
  validates :username, presence: true, uniqueness: true
  validate :private_namespace_and_team_available, on: :create
  after_create :create_personal_namespace!

  # Actions performed before destroy
  before_destroy :update_tags!

  belongs_to :namespace
  has_many :team_users
  has_many :teams, through: :team_users
  has_many :stars
  has_many :application_tokens

  scope :not_portus, -> { where.not username: "portus" }
  scope :enabled,    -> { not_portus.where enabled: true }
  scope :admins,     -> { not_portus.where enabled: true, admin: true }

  # Special method used by Devise to require an email on signup. This is always
  # true except for LDAP.
  def email_required?
    !(Portus::LDAP.enabled? && email.blank?)
  end

  # It adds an error if the username clashes with either a namespace or a team.
  def private_namespace_and_team_available
    ns = Namespace.make_valid(username)

    if ns.nil?
      errors.add(:username, "'#{username}' cannot be transformed into a " \
        "valid namespace name")
    elsif Namespace.exists?(name: ns)
      clar = (ns != username) ? " (modified so it's valid)" : ""
      errors.add(:username, "cannot be used: there is already a namespace " \
        "named '#{ns}'#{clar}")
    elsif Team.exists?(name: username)
      errors.add(:username, "cannot be used: there is already a team named " \
        "like this")
    end
  end

  # Returns true if the current user is the Portus user.
  def portus?
    username == "portus"
  end

  # Returns the username to be displayed.
  def display_username
    return username unless APP_CONFIG.enabled?("display_name")
    display_name.blank? ? username : display_name
  end

  # This method will be called automatically once a user is created. It will
  # also be created for each user of the system when a registry is saved in the
  # system.
  def create_personal_namespace!
    # the registry is not configured yet, we cannot create the namespace
    return unless Registry.any?

    # Leave early if the namespace already exists. This is fine because the
    # `private_namespace_and_team_available` method has already checked that
    # the name of the namespace is fine and that it doesn't clash.
    namespace_name = Namespace.make_valid(username)
    ns = Namespace.find_by(name: namespace_name)
    return ns if ns

    # Note that this shouldn't be a problem since the User controller will make
    # sure that we don't create a user that clashes with this team.
    team = Team.create!(name: username, owners: [self], hidden: true)

    default_description = "This personal namespace belongs to #{username}."
    namespace = Namespace.find_or_create_by!(
      team:        team,
      name:        namespace_name,
      visibility:  Namespace.visibilities[:visibility_private],
      description: default_description,
      registry:    Registry.get # TODO: fix once we handle more registries
    )
    update_attributes(namespace: namespace)
  end

  # Find the user that can be guessed from the given push event.
  def self.find_from_event(event)
    actor = User.find_by(username: event["actor"]["name"])
    logger.error "Cannot find user #{event["actor"]["name"]}" if actor.nil?
    actor
  end

  # Toggle the 'admin' attribute for this user. It will also update the
  # registry accordingly.
  def toggle_admin!
    admin = !admin?
    return unless update_attributes(admin: admin) && Registry.any?

    # TODO: fix once we handle more registries
    team = Registry.get.global_namespace.team
    admin ? team.owners << self : team.owners.delete(self)
  end

  ##
  # Enabling/disabling users.

  # Toggle the enabled attribute for a user. This is an instance method because
  # it is a user that enables/disables another user.
  def toggle_enabled!(user)
    enabled = user.enabled?

    # Return false if the action is not allowed.
    return false if enabled && !can_disable?(user)
    return false if !enabled && !admin?

    user.update_attributes(enabled: !enabled)
  end

  # This method is picked up by Devise before signing in a user.
  def active_for_authentication?
    super && enabled?
  end

  # The flashy message to be shown for disabled users that try to login.
  def inactive_message
    "Sorry, this account has been disabled."
  end

  # Returns all users who match the query.
  def self.search_from_query(members, query)
    enabled.where.not(id: members).where(arel_table[:username].matches(query))
  end

  # Looks for an application token that matches with the plain one provided
  # as parameter.
  # Return true if there's an application token matching it, false otherwise
  def application_token_valid?(plain_token)
    application_tokens.each do |t|
      if t.token_hash == BCrypt::Engine.hash_secret(plain_token, t.token_salt)
        return true
      end
    end

    false
  end

  # Update the tags owned by this user before this user gets destroyed.
  def update_tags!
    Tag.where(user_id: id).update_all(user_id: nil, username: username)
  end

  # Update the activities owned by this user. This method should only be called
  # before destroying this user.
  def update_activities!(owner)
    # Originally this was handled in a single query, but with that is was not
    # possible to fix a bug as specified in PR #1144. Now it's handled in a
    # block that ends up performing multiple queries, which we want to perform
    # atomically (thus the transaction).
    ActiveRecord::Base.transaction do
      PublicActivity::Activity.where(owner_id: id).find_each do |a|
        a.owner_id   = nil
        a.owner_type = nil
        a.parameters = a.parameters.merge(owner_name: display_username)
        a.save
      end
    end

    create_activity :delete,
                    owner:      owner,
                    parameters: { username: username }
  end

  protected

  # Returns whether the given user can be disabled or not. The following rules
  # apply:
  #   1. A user can disable himself unless it's the last admin on the system.
  #   2. The admin user is the only one that can disable other users.
  def can_disable?(user)
    # The "portus" user can never be disabled.
    return false if user.portus?

    if self == user
      # An admin cannot disable himself if he's the only admin in the system.
      # Otherwise, regular users can disable themselves.
      return true unless admin?
      User.admins.count > 1
    else
      # Only admin users can disable other users.
      admin?
    end
  end
end
