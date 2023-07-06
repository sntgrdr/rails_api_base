json.conversations do
  json.array! @conversations do |conversation|
    json.extract! conversation, :id, :user_from, :user_to, :created_at
    json.partial! 'targets', targets: conversation.targets
    json.partial! 'messages', messages: conversation.messages
  end
end
