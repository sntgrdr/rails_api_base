json.messages do
  json.array! messages do |message|
    json.extract! message, :id, :content, :user, :created_at
  end
end
