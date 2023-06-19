describe 'GET /api/v1/targets/:id', type: :request do
  let(:user) { create(:user) }
<<<<<<< HEAD
=======
  let(:target) { create(:target) }
>>>>>>> feature/create-target-model

  subject { get api_v1_target_path(target_id), headers: auth_headers, as: :json }

  context 'when the request is valid' do
<<<<<<< HEAD
    let(:target) { create(:target, user:) }
=======
>>>>>>> feature/create-target-model
    let!(:target_id) { target.id }

    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end
  end

  context 'when the request is not valid' do
    let(:target_id) { -1 }

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
