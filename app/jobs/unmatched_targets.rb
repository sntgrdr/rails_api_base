require 'sidekiq-scheduler'

class UnmatchedTargets
  # perform this job every day at 23:59
  include Sidekiq::Worker

  def perform
    targets = Target.where.not(id: ConversationTarget.pluck(:target_id))
                    .where('created_at <= ?', DateTime.now - 7.days)
    targets.destroy_all
  end
end
