# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  target_id  :bigint
#  user_from  :bigint
#  user_to    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_conversations_on_target_id  (target_id)
#  index_conversations_on_user_from  (user_from)
#  index_conversations_on_user_to    (user_to)
#
FactoryBot.define do
  factory :conversation do
    target
  end
end
