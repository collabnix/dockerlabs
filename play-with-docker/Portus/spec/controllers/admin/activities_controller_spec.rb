require "rails_helper"

RSpec.describe Admin::ActivitiesController, type: :controller do
  let(:admin) { create(:admin) }

  before :each do
    sign_in admin
  end

  describe "GET #index" do
    before :each do
      create(:registry)
    end

    it "paginates activities" do
      get :index
      expect(assigns(:activities)).to respond_to(:total_pages)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "export to csv" do
    render_views

    let(:user) { create(:user, username: "sammy") }
    let(:another_user) { create(:user, username: "dean") }
    let(:activity_owner) { create(:user, username: "castiel") }
    let(:registry) { create(:registry, hostname: "registry.test.lan") }
    let(:global_namespace) do
      create(:namespace,
             name:       "globalnamespace",
             registry:   registry,
             global:     true,
             team:       global_team,
             visibility: "visibility_public")
    end
    let(:namespace) { create(:namespace, name: "patched_images", registry: registry, team: team) }
    let(:team) { create(:team, name: "qa", owners: [user]) }
    let(:global_team) { create(:team, name: "globalteam", owners: [user]) }
    let(:repository) { create(:repository, name: "sles12", namespace: namespace) }
    let(:tag) { create(:tag, name: "1.0.0", repository: repository) }
    let(:global_repository) { create(:repository, name: "sles11sp3", namespace: global_namespace) }
    let(:global_tag) { create(:tag, name: "1.0.0", repository: global_repository) }

    before :each do
      Timecop.travel(Time.gm(2015))
      create(:activity_team_create,
             trackable_id: team.id,
             owner_id:     activity_owner.id)
      create(:activity_team_add_member,
             trackable_id: team.id,
             owner_id:     activity_owner.id,
             recipient_id: another_user.id,
             parameters:   { role: "viewer" })
      create(:activity_team_remove_member,
             trackable_id: team.id,
             owner_id:     activity_owner.id,
             recipient_id: another_user.id,
             parameters:   { role: "viewer" })
      create(:activity_team_change_member_role,
             trackable_id: team.id,
             owner_id:     activity_owner.id,
             recipient_id: another_user.id,
             parameters:   { old_role: "viewer", new_role: "contributor" })
      create(:activity_namespace_create,
             trackable_id: namespace.id,
             owner_id:     activity_owner.id)
      create(:activity_namespace_change_visibility,
             trackable_id: namespace.id,
             owner_id:     activity_owner.id,
             parameters:   { visibility: "visibility_public" })
      create(:activity_namespace_change_visibility,
             trackable_id: namespace.id,
             owner_id:     activity_owner.id,
             parameters:   { visibility: "visibility_protected" })
      create(:activity_namespace_change_visibility,
             trackable_id: namespace.id,
             owner_id:     activity_owner.id,
             parameters:   { visibility: "visibility_private" })
      create(:activity_repository_push,
             trackable_id: tag.repository.id,
             recipient_id: tag.id,
             owner_id:     activity_owner.id)
      create(:activity_repository_push,
             trackable_id: global_tag.repository.id,
             recipient_id: global_tag.id,
             owner_id:     activity_owner.id)
    end

    it "generates a csv file" do
      get :index, format: :csv
      expect(response.headers).to include(
        "Content-Disposition" => 'attachment; filename="activities.csv"',
        "Content-Type"        => "text/csv"
      )

      csv = <<CSV
Tracked item,Item,Event,Recipient,Triggered by,Time,Notes
team,qa,create,-,castiel,2015-01-01 00:00:00 UTC,-
team,qa,add member,dean,castiel,2015-01-01 00:00:00 UTC,role viewer
team,qa,remove member,dean,castiel,2015-01-01 00:00:00 UTC,role viewer
team,qa,change member role,dean,castiel,2015-01-01 00:00:00 UTC,from viewer to contributor
namespace,patched_images,create,-,castiel,2015-01-01 00:00:00 UTC,owned by team qa
namespace,patched_images,change visibility,-,castiel,2015-01-01 00:00:00 UTC,is public
namespace,patched_images,change visibility,-,castiel,2015-01-01 00:00:00 UTC,is protected
namespace,patched_images,change visibility,-,castiel,2015-01-01 00:00:00 UTC,is private
repository,patched_images/sles12:1.0.0,push tag,-,castiel,2015-01-01 00:00:00 UTC,-
repository,registry.test.lan/sles11sp3:1.0.0,push tag,-,castiel,2015-01-01 00:00:00 UTC,-
CSV

      expect(response.body).to eq(csv)
    end

    it "generates an CSV file with all the entries" do
      # Create activities way beyond a single page.
      Array.new(50) { rand(1000..10000) }.uniq.each do |nr|
        team = Team.new(name: "team#{nr}")
        team.owners << user
        team.save
        team.create_activity :create, owner: user
      end

      get :index, format: :csv
      expect(response.body.split("\n").size).to eq 61
    end
  end
end
