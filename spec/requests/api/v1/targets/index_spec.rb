describe 'GET /api/v1/targets', type: :request do
  let!(:targets) { create_list(:target, 4) }

  subject { get api_v1_targets_path, headers: auth_headers, as: :json }

  context 'when the request is valid' do
    let(:user) { create(:user) }
    before do
      user.targets = targets
    end

    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'returns the targets list count' do
      subject
      expect(json[:targets].count).to eq(4)
    end

    it 'returns the targets list' do
      subject
      expect(json[:targets].as_json(except: :topic)).to eq(targets.as_json(except: %i[topic_id
                                                                                      updated_at]))
    end

    it "returns the targets'topics list" do
      subject
      expect(json[:targets].pluck(:topic).pluck(:id)).to eq(targets.map(&:topic_id))
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
