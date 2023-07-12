require 'rails_helper'

RSpec.describe UnmatchedTargets, type: :worker do
  describe '#perform' do
    let!(:target_with_conversation) { create(:target) }
    let!(:conversation) { create(:conversation, :skip_validations) }
    let!(:conversation_target) do
      create(:conversation_target, conversation:, target: target_with_conversation)
    end
    let!(:target_without_conversation) { create(:target, created_at: DateTime.now - 10.days) }

    it 'destroys targets without corresponding conversation_targets' do
      expect {
        UnmatchedTargets.new.perform
      }.to change { Target.count }.by(-1)

      expect(Target.exists?(target_with_conversation.id)).to be true
    end
  end
end
