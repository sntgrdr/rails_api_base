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
FactoryBot.define do
  factory :conversation do
    targets { create_list(:target, 3) }
  end
end
