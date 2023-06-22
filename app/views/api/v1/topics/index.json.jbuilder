json.topics do
  json.array! @topics do |topic|
    json.extract! topic, :id, :name, :image, :created_at
  end
end
