# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  conversation_id :bigint
#  user_id         :bigint
#  content         :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :content, presence: true
end
