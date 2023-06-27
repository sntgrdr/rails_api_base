# == Schema Information
#
# Table name: conversation_users
#
#  id              :bigint           not null, primary key
#  conversation_id :bigint
#  user_id         :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_conversation_users_on_conversation_id  (conversation_id)
#  index_conversation_users_on_user_id          (user_id)
#
FactoryBot.define do
  factory :conversation_user do
    conversation
    user
  end
end
