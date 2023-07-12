describe 'GET /api/v1/conversations/:id', type: :request do
  let(:user) { create(:user) }

  subject { get api_v1_conversation_path(conversation_id), headers: auth_headers, as: :json }

  context 'when the request is valid' do
    let(:target) { create(:target) }
    let(:conversation) do
      create(:conversation, :skip_validations, user_from: user, user_to: target.user)
    end
    let!(:conversation_id) { conversation.id }
    let!(:messages) { create_list(:message, 24, conversation:, user:) }

    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'returns the proper message count' do
      subject
      expect(json[:messages].count).to eq(Pagy::VARS[:items])
    end
  end

  context 'when the request is not valid' do
    let(:conversation_id) { -1 }

    it 'returns not found' do
      subject
      expect(response).to have_http_status(:not_found)
    end

    it 'returns devise error' do
      subject
      expect(json[:error]).to eq("Couldn't find the record")
    end
  end
end
