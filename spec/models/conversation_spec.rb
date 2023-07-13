# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  user_from  :integer
#  user_to    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_conversations_on_user_from  (user_from)
#  index_conversations_on_user_to    (user_to)
#
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe 'associations' do
    it { should have_many(:messages).dependent(:destroy) }
    it { should have_many(:conversation_targets).dependent(:destroy) }
    it { should have_many(:targets).through(:conversation_targets) }
    it {
      should belong_to(:user_from).class_name('User')
                                  .with_foreign_key('user_from')
    }
    it {
      should belong_to(:user_to).class_name('User')
                                .with_foreign_key('user_to')
    }
  end

  describe '#conversation_users' do
    context 'when the entity is invalid' do
      let!(:error_message) { I18n.t('api.errors.model.conversation.same_users') }
      let(:user) { create(:user) }
      let(:conversation) { build(:conversation, user_from: user, user_to: user) }
      before do
        user_latitude = conversation.targets.last.latitude
        user_longitude = conversation.targets.last.longitude
        user.update!(latitude: user_latitude, longitude: user_longitude)
      end

      it 'return error message' do
        expect(conversation).not_to be_valid
        expect(conversation.errors[:base]).to eq([error_message])
      end
    end

    context 'when the entity is valid' do
      let(:user) { create(:user) }
      let(:conversation) { build(:conversation, user_from: user, user_to: user) }
      before do
        user_latitude = conversation.targets.last.latitude
        user_longitude = conversation.targets.last.longitude
        user.update!(latitude: user_latitude, longitude: user_longitude)
      end

      it 'return creates the conversation' do
        conversation.user_to = create(:user)
        expect(conversation).to be_valid
        expect(conversation.errors[:base]).to be_empty
      end
    end
  end

  describe '#within_range' do
    context 'when the entity is invalid' do
      let(:user) { create(:user, latitude: 40.7128, longitude: -74.0060) }
      let(:target) { create(:target, radius: 1, latitude: 40.7128, longitude: -74.0019) }
      let!(:conversation) { build(:conversation, user_from: user, user_to: target.user) }
      let!(:error_message) { I18n.t('api.errors.model.conversation.out_of_range') }

      it 'return error message' do
        expect(conversation).not_to be_valid
        expect(conversation.errors[:base]).to eq([error_message])
      end
    end

    context 'when the entity is valid' do
      let(:user) { create(:user) }
      let(:conversation) { build(:conversation, user_from: user, user_to: user) }
      before do
        user_latitude = conversation.targets.last.latitude + 0.1
        user_longitude = conversation.targets.last.longitude
        user.update!(latitude: user_latitude, longitude: user_longitude)
      end

      it 'return creates the conversation' do
        conversation.user_to = create(:user)
        expect(conversation).to be_valid
        expect(conversation.errors[:base]).to be_empty
      end
    end
  end
end
