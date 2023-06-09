module Api
  module V1
    class TargetsController < ApiController
      def create
        authorize Target
        @target = current_user.targets.create!(target_params)
        render :show
      end

      def show
        authorize Target
        target
      end

      def index
        @targets = policy_scope(current_user.targets.preload(:topic)
                                            .includes(topic: { image_attachment: :blob }))
      end

      def destroy
        authorize target
        @target.destroy!
        head :ok
      end

      private

      def target_params
        params.require(:target).permit(:topic_id, :title, :radius, :latitude, :longitude)
      end

      def target
        @target = Target.find(params[:id])
      end
    end
  end
end
