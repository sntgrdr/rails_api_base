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
  end
end
