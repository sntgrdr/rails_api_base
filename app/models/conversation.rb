# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  user_from  :bigint
#  user_to    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_conversations_on_user_from  (user_from)
#  index_conversations_on_user_to    (user_to)
#
class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :conversation_targets, dependent: :destroy
  has_many :targets, through: :conversation_targets
  belongs_to :user_from, class_name: 'User', foreign_key: 'user_from'
  belongs_to :user_to, class_name: 'User', foreign_key: 'user_to'

  validate :conversation_users

  scope :related_to_current_user, lambda { |user|
                                    where('user_from = :user_id OR user_to = :user_id',
                                          user_id: user.id)
                                  }
  scope :with_ordered_messages, -> { includes(:messages).order(created_at: :desc) }

  private

  def conversation_users
    return unless user_from == user_to

    errors.add(:base, I18n.t('api.errors.model.conversation.same_users'))
  end
end
