module Api
  module V1
    class MessagesController < ApiController
      def create
        authorize Message
        conversation.messages.create!(message_params)
        head :ok
      end

      private

      def message_params
        params.require(:message).permit(:content).merge(user: current_user)
      end

      def conversation
        @conversation = Conversation.find(params[:conversation_id])
      end
    end
  end
end
