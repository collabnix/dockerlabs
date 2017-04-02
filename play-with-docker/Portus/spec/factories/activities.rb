FactoryGirl.define do

  factory :activity_team_create, class: PublicActivity::Activity do
    owner_type "User"
    key "team.create"
    trackable_type "Team"
  end

  factory :activity_team_add_member, class: PublicActivity::Activity do
    owner_type "User"
    key "team.add_member"
    trackable_type "Team"
    recipient_type "User"
  end

  factory :activity_team_remove_member, class: PublicActivity::Activity do
    owner_type "User"
    key "team.remove_member"
    trackable_type "Team"
    recipient_type "User"
  end

  factory :activity_team_change_member_role, class: PublicActivity::Activity do
    owner_type "User"
    key "team.change_member_role"
    trackable_type "Team"
    recipient_type "User"
  end

  factory :activity_namespace_create, class: PublicActivity::Activity do
    owner_type "User"
    key "namespace.create"
    trackable_type "Namespace"
  end

  factory :activity_namespace_change_visibility, class: PublicActivity::Activity do
    owner_type "User"
    key "namespace.change_visibility"
    trackable_type "Namespace"
  end

  factory :activity_repository_push, class: PublicActivity::Activity do
    owner_type "User"
    key "repository.push"
    trackable_type "Repository"
    recipient_type "Tag"
  end

  factory :activity_application_token_created, class: PublicActivity::Activity do
    trackable_type "ApplicationToken"
    owner_type "User"
    key "application_token.created"
    parameters Hash.new(application: "test application")
  end

  factory :activity_application_token_destroyed, class: PublicActivity::Activity do
    trackable_type "ApplicationToken"
    owner_type "User"
    key "application_token.destroyed"
    parameters Hash.new(application: "test application")
  end

  factory :activity_webhook_create, class: PublicActivity::Activity do
    trackable_type "Webhook"
    owner_type "User"
    key "webhook.create"
  end

  factory :activity_webhook_destroy, class: PublicActivity::Activity do
    trackable_type "Webhook"
    owner_type "User"
    key "webhook.destroy"
  end
end
