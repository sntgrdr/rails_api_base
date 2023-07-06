json.conversations do
  json.array! @conversations do |conversation|
    json.extract! conversation, :id, :target_id, :user_from, :user_to, :created_at
    json.partial! 'messages', messages: conversation.messages
  end
end
