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
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe 'associations' do
    it { should have_many(:messages).dependent(:destroy) }
    it {
      should belong_to(:user_from).class_name('User')
                                  .with_foreign_key('user_from')
    }
    it {
      should belong_to(:user_to).class_name('User')
                                .with_foreign_key('user_to')
    }
    it { should belong_to(:target) }
  end

  describe '#conversation_users' do
    context 'when the entity is invalid' do
      let(:user) { create(:user) }
      let(:conversation) { build(:conversation, user_from: user, user_to: user) }
      let!(:error_message) { I18n.t('api.errors.model.conversation.same_users') }

      it 'return error message' do
        expect(conversation).not_to be_valid
        expect(conversation.errors[:base]).to eq([error_message])
      end
    end

    context 'when the entity is valid' do
      let(:user) { create(:user) }
      let(:conversation) { build(:conversation, user_from: user, user_to: user) }

      it 'return creates the conversation' do
        conversation.user_to = create(:user)
        expect(conversation).to be_valid
        expect(conversation.errors[:base]).to be_empty
      end
    end
  end
end
