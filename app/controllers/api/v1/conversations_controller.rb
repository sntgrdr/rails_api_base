module Api
  module V1
    class ConversationsController < ApiController
      include Pagy::Backend
      before_action :target, only: :create
      before_action :conversation, only: :show

      def index
        @conversations = policy_scope(Conversation.related_to_current_user(current_user)
                                                  .includes(%i[user_from user_to targets]))
      end

      def create
        authorize Conversation
        @conversation = find_or_create_conversation(target.user)
        @conversation.targets << target

        render :show if @conversation.save!
      end

      def show
        authorize Conversation
        @pagy, @records = pagy(@conversation.messages.includes(:user).order(created_at: :desc))
      end

      private

      def conversation
        @conversation = Conversation.find(params[:id])
      end

      def target
        @target = Target.find(params[:target_id])
      end

      def find_or_create_conversation(user_to)
        Conversation.preload(:messages).find_or_initialize_by(user_to:,
                                                              user_from: current_user)
      end
    end
  end
end
