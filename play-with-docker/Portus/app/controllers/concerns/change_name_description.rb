module ChangeNameDescription
  extend ActiveSupport::Concern

  # Update the attributes name or description of a ActiveRecord-object.
  def change_name_description(object, symbol, params, activity_params = {})
    authorize object

    new_name = params[:name]
    new_description = params[:description]
    old_description = object.description
    old_name = object.name

    change_description(object, symbol, old_description, new_description, activity_params)
    change_name(object, symbol, old_name, new_name, activity_params)
  end

  private

  # Create a PublicActivity for updating an attribute.
  def create_activity(object, symbol, old_value, new_value, activity_params)
    object.create_activity "change_#{symbol}".to_sym,
                                  owner:      current_user,
                                  recipient:  object,
                                  parameters: activity_params.merge(old: old_value, new: new_value)
  end

  # Change description and track activity if successful.
  def change_description(object, symbol, old_description, new_description, activity_params)
    return if new_description.nil? || old_description == new_description ||
        !object.update(description: new_description)
    create_activity(object, "#{symbol}_description", old_description,
                    new_description, activity_params)
  end

  # Change name and track activity if successful.
  def change_name(object, symbol, old_name, new_name, activity_params)
    return if old_name == new_name || new_name.blank? || !object.update(name: new_name)
    create_activity(object, "#{symbol}_name", old_name, new_name, activity_params)
  end
end
