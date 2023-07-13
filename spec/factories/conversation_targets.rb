# == Schema Information
#
# Table name: conversation_targets
#
#  id              :bigint           not null, primary key
#  conversation_id :bigint
#  target_id       :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_conversation_targets_on_conversation_id  (conversation_id)
#  index_conversation_targets_on_target_id        (target_id)
#
FactoryBot.define do
  factory :conversation_target do
    conversation
    target
  end
end
