module Api
  module V1
    class TopicsController < Api::V1::ApiController
      def index
        @topics = policy_scope(Topic).includes(image_attachment: :blob)
      end
    end
  end
end
