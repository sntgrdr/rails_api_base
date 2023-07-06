module Api
  module V1
    class ConversationsController < ApiController
      def index
        @conversations = policy_scope(Conversation.related_to_current_user(current_user)
                                                  .includes(%i[user_from user_to targets])
                                                  .includes(messages: [:user])
                                                  .with_ordered_messages)
      end
    end
  end
end
