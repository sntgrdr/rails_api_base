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
FactoryBot.define do
  factory :conversation do
    target
  end
end
