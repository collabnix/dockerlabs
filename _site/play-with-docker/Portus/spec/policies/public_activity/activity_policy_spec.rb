require "rails_helper"

describe PublicActivity::ActivityPolicy do

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:viewer) { create(:user) }
  let(:contributor) { create(:user) }
  let(:activity_owner) { create(:user) }
  let(:registry) { create(:registry) }
  let(:namespace) { create(:namespace, registry: registry, team: team) }
  let(:team) { create(:team, owners: [user], contributors: [contributor], viewers: [viewer]) }
  let(:repository) { create(:repository, namespace: namespace) }
  let(:tag) { create(:tag, repository: repository) }
  let(:webhook) { create(:webhook, namespace: namespace, url: "http://example.com") }

  subject { described_class }

  describe "scope" do
    it "returns pertinent team activities" do
      activities = [
        create_activity_team_create(team, activity_owner),
        create_activity_team_add_member(team, activity_owner, another_user),
        create_activity_team_change_member_role(
          team, activity_owner, another_user, "viewer", "owner"
        ),
        create_activity_team_remove_member(team, activity_owner, another_user)
      ]

      # ignored events, not related with a team the user is member of
      create_activity_team_create(create(:team), another_user)

      expect(Pundit.policy_scope(user, PublicActivity::Activity).to_a).to match_array(activities)
    end

    it "returns pertinent namespace events" do
      namespace2 = create(:namespace,
                          registry:   registry,
                          team:       create(:team, owners: [another_user]),
                          visibility: Namespace.visibilities[:visibility_public])

      activities = [
        create(:activity_namespace_create,
               trackable_id: namespace.id,
               owner_id:     activity_owner.id),
        create(:activity_namespace_change_visibility,
               trackable_id: namespace.id,
               owner_id:     activity_owner.id),
        create(:activity_namespace_change_visibility,
               trackable_id: namespace.id,
               owner_id:     activity_owner.id),
        # all the public/private events are shown, even the ones
        # involving namespaces the user does not control
        create(:activity_namespace_change_visibility,
               trackable_id: namespace2.id,
               owner_id:     activity_owner.id),
        create(:activity_namespace_change_visibility,
               trackable_id: namespace2.id,
               owner_id:     activity_owner.id)
      ]

      create(:activity_namespace_create,
             trackable_id: namespace2.id,
             owner_id:     activity_owner.id)

      expect(Pundit.policy_scope(user, PublicActivity::Activity).to_a).to match_array(activities)
    end

    it "returns pertinent repository events" do
      namespace2 = create(:namespace,
                          registry: registry,
                          team:     create(:team,
                                       owners: [another_user]))
      private_tag = create(:tag, repository: create(:repository, namespace: namespace2))

      public_namespace = create(:namespace,
                                registry:   registry,
                                visibility: Namespace.visibilities[:visibility_public],
                                team:       create(:team,
                                             owners:     [another_user],
                                             namespaces: [namespace2]))
      public_tag = create(:tag, repository: create(:repository, namespace: public_namespace))

      activities = [
        create(:activity_repository_push,
               trackable_id: tag.repository.id,
               recipient_id: tag.id,
               owner_id:     activity_owner.id),
        # Tag made inside of public namespaces are shown even
        # if the user does not control their namespace
        create(:activity_repository_push,
               trackable_id: public_tag.repository.id,
               recipient_id: public_tag.id,
               owner_id:     activity_owner.id)
      ]

      create(:activity_namespace_create,
             trackable_id: private_tag.id,
             owner_id:     activity_owner.id)

      expect(Pundit.policy_scope(user, PublicActivity::Activity).to_a).to match_array(activities)
    end

    it "mixes different types of activities" do
      activities = [
        create_activity_team_create(team, activity_owner),
        create(:activity_namespace_create,
               trackable_id: namespace.id,
               owner_id:     activity_owner.id),
        create(:activity_repository_push,
               trackable_id: tag.repository.id,
               recipient_id: tag.id,
               owner_id:     activity_owner.id),
        create_activity_application_token_created(user)
      ]

      expect(Pundit.policy_scope(user, PublicActivity::Activity).to_a).to match_array(activities)
    end

    it "returns pertinent application token activities" do
      # application token owned by another user
      create_activity_application_token_created(create(:user))

      activities = [
        create_activity_application_token_created(user)
      ]

      expect(Pundit.policy_scope(user, PublicActivity::Activity).to_a).to match_array(activities)
    end

    it "returns pertinent webhook activities" do
      activities = [
        create_activity_webhook_create(webhook, activity_owner),
        create_activity_webhook_destroy(webhook, activity_owner, namespace)
      ]

      expect(Pundit.policy_scope(user, PublicActivity::Activity).to_a).to match_array(activities)
      expect(Pundit.policy_scope(contributor, PublicActivity::Activity).to_a)
        .to match_array(activities)
      expect(Pundit.policy_scope(viewer, PublicActivity::Activity).to_a).to match_array(activities)
      expect(Pundit.policy_scope(another_user, PublicActivity::Activity).to_a).to be_empty
    end
  end

  private

  def create_activity_team_create(team, activity_owner)
    create(:activity_team_create,
           trackable_id: team.id,
           owner_id:     activity_owner.id)
  end

  def create_activity_team_add_member(team, event_owner, new_member, role = "viewer")
    create(:activity_team_add_member,
           trackable_id: team.id,
           owner_id:     event_owner.id,
           recipient_id: new_member.id,
           parameters:   { role: role })
  end

  def create_activity_team_remove_member(team, event_owner, old_member, role = "viewer")
    create(:activity_team_remove_member,
           trackable_id: team.id,
           owner_id:     event_owner.id,
           recipient_id: old_member.id,
           parameters:   { role: role })
  end

  def create_activity_team_change_member_role(team, event_owner, member, old_role, new_role)
    create(:activity_team_change_member_role,
           trackable_id: team.id,
           owner_id:     event_owner.id,
           recipient_id: member.id,
           parameters:   { old_role: old_role, new_role: new_role })
  end

  def create_activity_application_token_created(owner)
    token = create(:application_token, user: owner)
    create(:activity_application_token_created,
           trackable_id: token.id,
           owner_id:     owner.id)
  end

  def create_activity_webhook_create(webhook, activity_owner)
    create(:activity_webhook_create,
           trackable_id: webhook.id,
           owner_id:     activity_owner.id)
  end

  def create_activity_webhook_destroy(webhook, activity_owner, namespace)
    create(:activity_webhook_destroy,
           trackable_id: webhook.id,
           owner_id:     activity_owner.id,
           parameters:   { namespace_id:   namespace.id,
                           namespace_name: namespace.name,
                           webhook_url:    webhook.url,
                           webhook_host:   webhook.host })
  end
end
