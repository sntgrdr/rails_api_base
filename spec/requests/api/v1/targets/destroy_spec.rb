describe 'DELETE /api/v1/targets/:id', type: :request do
  let(:user) { create(:user) }

  subject { delete api_v1_target_path(target_id), headers: auth_headers, as: :json }

  context 'when the request is valid' do
    let(:target) { create(:target, user:) }
    let!(:target_id) { target.id }

    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'deletes the Target' do
      expect { subject }.to change { Target.count }.from(1).to(0)
    end
  end

  context 'when the request is not valid' do
    let(:other_user) { create(:user) }
    let(:target) { create(:target, user: other_user) }
    let!(:target_id) { target.id }

    it 'returns not found' do
      expect { subject }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
