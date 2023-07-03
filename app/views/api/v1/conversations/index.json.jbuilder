json.conversations do
  json.array! @conversations do |conversation|
    json.extract! conversation, :id, :target_id, :user_from, :user_to, :created_at
    json.messages do
      json.array! conversation.messages do |message|
        json.extract! message, :id, :content, :user, :created_at
      end
    end
  end
end
