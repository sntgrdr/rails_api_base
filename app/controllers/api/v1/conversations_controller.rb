module Api
  module V1
    class ConversationsController < ApiController
      before_action :target, only: :create

      def index
        @conversations = policy_scope(Conversation.related_to_current_user(current_user)
                                                  .includes(%i[user_from user_to targets])
                                                  .includes(messages: [:user])
                                                  .with_ordered_messages)
      end

      def create
        authorize Conversation
        @conversation = find_or_create_conversation(target.user)
        @conversation.targets << target

        render :show if @conversation.save!
      end

      private

      def target
        @target = Target.find(params[:target_id])
      end

      def find_or_create_conversation(user_to)
        Conversation.joins(:messages).find_or_initialize_by(user_to:,
                                                            user_from: current_user)
      end
    end
  end
end
