class MovePublicToVisibilityOnNamespace < ActiveRecord::Migration
  def up
    Namespace.all.each do |namespace|
      namespace.visibility = namespace.public? ? :visibility_public : :visibility_private
      namespace.save!
    end
    PublicActivity::Activity.where("activities.key = ? OR activities.key = ?",
                                   "private", "public").each do |activity|
      activity.parameters = { visibility: "visibility_#{activity.key}" }
      activity.key = "namespace.change_visibility"
      activity.save!
    end
  end

  def down
    Namespace.all.each do |namespace|
      namespace.public = namespace.visibility_public? ? true : false
      namespace.save!
    end
    PublicActivity::Activity.where(key: "change_visibility").each do |activity|
      if activity.parameters[:visibility] == 'visibility_private'
        activity.key = "namespace.private"
      else
        # protected namespace are made public as well
        activity.key = "namespace.public"
      end
      activity.parameters = {}
      activity.save!
    end
  end
end
