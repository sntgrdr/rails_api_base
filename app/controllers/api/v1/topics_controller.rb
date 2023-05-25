module Api
  module V1
    class TopicsController < Api::V1::ApiController
      before_action :topics

      def index
        authorize Topic
      end

      private

      def topics
        @topics = policy_scope(Topic)
      end
    end
  end
end
