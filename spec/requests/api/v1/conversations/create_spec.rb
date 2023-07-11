describe 'POST /api/v1/conversations', type: :request do
  let!(:target) { create(:target) }
  let!(:user) { create(:user, latitude: target.latitude, longitude: target.longitude) }
  let(:params) { { target_id: target.id } }

  subject { post api_v1_conversations_path, params:, headers: auth_headers, as: :json }

  context 'when the request is valid' do
    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'creates a new target' do
      expect {
        subject
      }.to change(Conversation, :count).by(1)
    end

    it 'returns the targets attributes' do
      subject
      expect(json[:id]).to eq(Conversation.last.id)
      expect(json[:user_from][:id]).to eq(user.id)
      expect(json[:user_to][:id]).to eq(target.user_id)
    end
  end

  context 'when the request is not valid' do
    context 'when the user is out of range' do
      let!(:user) { create(:user) }

      it 'returns bad_request' do
        subject
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message' do
        subject
        expect(json[:errors][:base]).to eq([I18n.t('api.errors.model.conversation.out_of_range')])
      end
    end

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
