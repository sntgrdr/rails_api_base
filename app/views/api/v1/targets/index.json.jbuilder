json.targets do
  json.array! @targets do |target|
    json.extract! target, :id, :user_id, :title, :radius, :latitude, :longitude, :created_at
    json.topic do
      json.extract! target.topic, :id, :name, :image
    end
  end
end
