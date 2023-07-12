json.extract! @conversation, :id, :user_from, :user_to, :created_at

json.partial! 'messages', locals: { pagy: @pagy, records: @records }
