describe 'GET /api/v1/topics', type: :request do
  let!(:topics) { create_list(:topic, 4) }

  subject { get api_v1_topics_path, headers: auth_headers, as: :json }

  context 'when the request is valid' do
    let(:user) { create(:user) }

    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'returns the topics list count' do
      subject
      expect(json[:topics].count).to eq(4)
    end

    it 'returns the topics list' do
      subject
      expect(json[:topics].as_json(except: :image)).to eq(topics.as_json(except: :updated_at))
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
