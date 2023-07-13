json.targets do
  json.array! targets do |target|
    json.extract! target, :id, :topic_id, :title, :radius, :latitude, :longitude
  end
end
