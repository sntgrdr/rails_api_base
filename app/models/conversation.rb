# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  target_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_conversations_on_target_id  (target_id)
#
class Conversation < ApplicationRecord
  MAX_USERS = 2

  has_many :messages, dependent: :destroy
  has_many :conversation_users, dependent: :destroy
  has_many :users, through: :conversation_users
  belongs_to :target

  validate :users_count, on: :create

  private

  def users_count
    users.size == MAX_USERS
  end
end
