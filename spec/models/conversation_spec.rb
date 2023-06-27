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
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe 'associations' do
    it { should have_many(:messages).dependent(:destroy) }
    it { should have_many(:conversation_users).dependent(:destroy) }
    it { should have_many(:users).through(:conversation_users) }
    it { should belong_to(:target) }
  end
end
