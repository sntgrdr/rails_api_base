describe 'POST /api/v1/conversations/:conversation_id/messages', type: :request do
  let!(:target) { create(:target) }
  let(:user) { create(:user, latitude: target.latitude, longitude: target.longitude) }
  let(:conversation) do
    create(:conversation, :skip_validations, user_from: user, user_to: target.user)
  end
  let!(:conversation_target) do
    ConversationTarget.create!(conversation_id: conversation.id, target_id: target.id)
  end
  let!(:conversation_id) { conversation.id }
  let!(:params) { { content: 'test' } }

  subject do
    post api_v1_conversation_messages_path(conversation_id:), params:, headers: auth_headers,
                                                              as: :json
  end

  context 'when the request is valid' do
    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'creates a new message' do
      expect {
        subject
      }.to change(Message, :count).by(1)
    end
  end

  context 'when the request is not valid' do
    context 'when the user is invalid' do
      let(:auth_headers) { {} }

      it 'returns unauthorized' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns devise error' do
        subject
        expect(json[:errors]).to eq([I18n.t('devise.failure.unauthenticated')])
      end
    end
  end
end
