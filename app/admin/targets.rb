ActiveAdmin.register Target do
  permit_params :topic_id, :user_id, :title, :radius, :latitude, :longitude, :user_email

  index do
    id_column
    column :topic do |target|
      link_to target.topic_name, admin_topic_path(target.topic)
    end
    column :user do |target|
      link_to target.user_email, admin_user_path(target.user)
    end
    column :title
    column :radius
    column :latitude
    column :longitude
    actions
  end
end
