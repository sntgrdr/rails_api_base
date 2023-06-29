describe 'POST /api/v1/targets', type: :request do
  let!(:topic) { create(:topic) }
  let(:params) { attributes_for(:target).merge(topic_id: topic.id) }

  subject { post api_v1_targets_path, params:, headers: auth_headers, as: :json }

  context 'when the request is valid' do
    let!(:user) { create(:user) }

    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'creates a new target' do
      expect {
        subject
      }.to change(Target, :count).by(1)
    end

    it 'returns the targets attributes' do
      subject
      expect(json[:id]).to eq(Target.last.id)
      expect(json[:topic_id]).to eq(topic.id)
      expect(json[:title]).to eq(params[:title])
      expect(json[:radius]).to eq(params[:radius].to_f.round(2).to_s)
      expect(json[:latitude]).to eq(params[:latitude].to_f.round(6).to_s)
      expect(json[:longitude]).to eq(params[:longitude].to_f.round(6).to_s)
    end
  end

  context 'when the request is not valid' do
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
