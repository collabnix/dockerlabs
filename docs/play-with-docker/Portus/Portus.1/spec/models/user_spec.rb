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

require "rails_helper"

describe User do
  subject { create(:user) }

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:username) }
  it { should allow_value("test1", "1test").for(:username) }

  describe "#private_namespace_and_team_available" do
    it "adds an error if the username cannot produce a valid namespace" do
      user = build(:user, username: "!!!!!")
      expect(user.save).to be false
      expect(user.errors.size).to eq(1)
      expect(user.errors.first)
        .to match_array([:username, "'!!!!!' cannot be transformed into a " \
          "valid namespace name"])
    end

    it "adds an error if the namespace name clashes" do
      name = "coolname"
      team = create(:team, owners: [subject])
      create(:namespace, team: team, name: name)

      user = build(:user, username: name)
      expect(user.save).to be false
      expect(user.errors.size).to eq(1)
      expect(user.errors.first)
        .to match_array([:username, "cannot be used: there is already a " \
          "namespace named 'coolname'"])

      user = build(:user, username: name + "_")
      expect(user.save).to be false
      expect(user.errors.size).to eq(1)
      expect(user.errors.first)
        .to match_array([:username, "cannot be used: there is already a " \
          "namespace named 'coolname' (modified so it's valid)"])
    end

    it "adds an error if there's a team named like that" do
      name = "coolname"
      team = create(:team, name: name, owners: [subject])
      create(:namespace, team: team, name: "somethingelse")

      user = build(:user, username: name)
      expect(user.save).to be false
      expect(user.errors.size).to eq(1)
      expect(user.errors.first)
        .to match_array([:username, "cannot be used: there is already a " \
          "team named like this"])
    end

    it "works beautifully if everything was fine" do
      name = "coolname"
      team = create(:team, owners: [subject])
      create(:namespace, team: team, name: "somethingelse")

      user = build(:user, username: name)
      expect(user.save).to be_truthy
      expect(user.errors).to be_empty
    end
  end

  it "#email_required?" do
    expect(subject.email_required?).to be true

    APP_CONFIG["ldap"] = { "enabled" => true }
    incomplete = create(:user, email: "")

    expect(subject.email_required?).to be true
    expect(incomplete.email_required?).to be false
  end

  it "calls create_personal_team! on a user" do
    create(:registry)
    expect(Namespace.find_by(name: "test")).to be nil

    user2 = create(:user, username: "test")
    namespace = Namespace.find_by(name: "test")
    expect(namespace).to_not be nil
    expect(user2.namespace.id).to eq namespace.id
  end

  describe ".find_from_event" do
    let!(:user)   { create(:user, username: "username001") }

    it "find user by username" do
      APP_CONFIG["ldap"] = { "enabled" => false }
      event = { "actor" => { "name" => "username001" } }
      expect(User.find_from_event(event)).not_to be_nil
    end
  end

  describe "#create_personal_namespace!" do
    context "no registry defined yet" do
      before :each do
        expect(Registry.count).to be(0)
      end

      it "does nothing" do
        subject.create_personal_namespace!

        expect(Team.find_by(name: subject.username)).to be(nil)
        expect(Namespace.find_by(name: subject.username)).to be(nil)
      end

    end

    context "registry defined" do
      before :each do
        create(:admin)
        create(:registry)
      end

      it "creates a team and a namespace with the name of username" do
        subject.create_personal_namespace!
        team = Team.find_by!(name: subject.username)
        Namespace.find_by!(name: subject.username)
        TeamUser.find_by!(user: subject, team: team)
        expect(team.owners).to include(subject)
        expect(team).to be_hidden
      end

      it "creates a namespace with the modified username" do
        user = build(:user, username: "name_")
        expect(user.save).to be_truthy
        Namespace.find_by!(name: "name")
      end
    end
  end

  describe "admins" do
    let!(:admin1) { create(:admin) }
    let!(:admin2) { create(:admin, enabled: false) }

    it "computes the right amount of admin users" do
      admins = User.admins
      expect(admins.count).to be 1
      expect(admins.first.id).to be admin1.id
    end
  end

  describe "#toggle_admin" do
    let!(:registry) { create(:registry) }
    let!(:user) { create(:user) }

    it "Toggles the admin attribute" do
      # We have a registry and the admin user is the owner.
      admin = User.where(admin: true).first
      owners = registry.global_namespace.team.owners
      expect(owners.count).to be(1)
      expect(owners.first.id).to be(admin.id)

      # Now we set the new user as another admin.
      user.toggle_admin!
      owners = registry.global_namespace.team.owners
      expect(user.admin?).to be true
      expect(owners.count).to be(2)

      # Now we remove it as an admin again
      user.toggle_admin!
      owners = registry.global_namespace.team.owners
      expect(owners.count).to be(1)
      expect(owners.first.id).to be(admin.id)
    end
  end

  describe "disabling" do
    let!(:admin) { create(:admin) }
    let!(:user)  { create(:user) }
    let!(:team)  { create(:team, owners: [admin], viewers: [user]) }

    it "interacts with Devise as expected" do
      expect(user.active_for_authentication?).to be true
      user.update_attributes(enabled: false)
      expect(user.active_for_authentication?).to be false
    end
  end

  describe "#toggle_enabled!" do
    let!(:admin) { create(:admin) }
    let!(:user)  { create(:user)  }

    describe "target user is enabled" do
      let!(:another) { create(:user) }

      it "does not allow the only admin to disable itself" do
        # portus is not a "real" admin, so it shouldn't count.
        create(:admin, username: "portus")
        expect(admin.toggle_enabled!(admin)).to be false
        expect(admin.enabled?).to be true
      end

      it "does not allow to disable the portus user" do
        portus = create(:admin, username: "portus")
        expect(admin.toggle_enabled!(portus)).to be false
        expect(portus.enabled?).to be true
      end

      it "does not allow to disable another user if current is not admin" do
        expect(user.toggle_enabled!(another)).to be false
        expect(another.enabled?).to be true
      end

      it "allows to disable another user if admin" do
        expect(admin.toggle_enabled!(another)).to be true
        expect(another.enabled?).to be false
      end

      it "allows to disable itself if there are more admins" do
        another_admin = create(:admin)
        expect(admin.toggle_enabled!(another_admin)).to be true
        expect(another_admin.enabled?).to be false
      end

      it "allows to disable itself if it's a regular user" do
        expect(user.toggle_enabled!(user)).to be true
        expect(user.enabled?).to be false
      end
    end

    describe "target user is disabled" do
      it "only allows admin users to enable users back" do
        disabled = create(:user, enabled: false)

        expect(user.toggle_enabled!(disabled)).to be false
        expect(disabled.enabled?).to be false

        expect(admin.toggle_enabled!(disabled)).to be true
        expect(disabled.enabled?).to be true
      end
    end
  end

  describe "#application_token_valid?" do
    let(:user) { create(:user) }

    it "returns false when there are no tokens" do
      expect(user.application_token_valid?("foo")).to be false
    end

    it "returns true when there's a token matching" do
      # the factory uses appication's name as plain token
      create(:application_token, application: "good", user: user)
      create(:application_token, application: "bad", user: user)
      expect(user.application_token_valid?("good")).to be true
    end

    it "returns false when there's no token matching" do
      # the factory uses appication's name as plain token
      create(:application_token, application: "bad", user: user)
      expect(user.application_token_valid?("good")).to be false
    end
  end

  describe "#display_username" do
    let(:user)  { build(:user, username: "user", display_name: "display") }
    let(:user2) { build(:user, username: "user") }

    it "returns the username of the feature is disabled" do
      expect(user.display_username).to eq user.username
    end

    it "returns the username/display_name if the feature is enabled" do
      APP_CONFIG["display_name"] = { "enabled" => true }
      expect(user2.display_username).to eq user.username
      expect(user.display_username).to eq user.display_name
    end
  end

  describe "#destroy" do
    let!(:registry)   { create(:registry, hostname: "registry.test.lan") }
    let!(:user)       { create(:admin, username: "admin") }
    let!(:user2)      { create(:user, username: "user") }
    let!(:repo)       { create(:repository, namespace: registry.global_namespace, name: "repo") }
    let!(:tag)        { create(:tag, name: "t", repository: repo, user_id: user.id, digest: "1") }

    it "updates tags being owned by this user on destroy" do
      create(:tag, name: "tag", repository: repo, digest: "1")
      user.destroy

      t = Tag.find_by(name: "t")
      expect(t.user_id).to be_nil
      expect(t.username).to eq "admin"
    end
  end
end
