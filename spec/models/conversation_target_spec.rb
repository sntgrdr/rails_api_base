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
require 'rails_helper'

RSpec.describe ConversationTarget, type: :model do
  describe 'associations' do
    it { should belong_to(:conversation) }
    it { should belong_to(:target) }
  end
end
