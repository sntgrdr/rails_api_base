describe 'GET /api/v1/conversations', type: :request do
  subject { get api_v1_conversations_path, headers: auth_headers, as: :json }

  context 'when the request is valid' do
    let!(:user) { create(:user) }
    let!(:second_user) { create(:user) }
    let!(:third_user) { create(:user) }
    let!(:conversation) do
      create(:conversation, :skip_validations, user_from: user, user_to: second_user)
    end
    let!(:second_conversation) do
      create(:conversation, :skip_validations, user_from: third_user, user_to: user)
    end
    let!(:expected_conversations) { [conversation, second_conversation] }
    let!(:expected_messages) { [conversation.messages, second_conversation.messages] }
    let!(:user_message) { create(:message, user:, conversation:) }
    let!(:response_message) { create(:message, user: second_user, conversation:) }
    let!(:user_message2) { create(:message, user: third_user, conversation: second_conversation) }
    let!(:response_message2) { create(:message, user:, conversation: second_conversation) }

    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end

    context 'when the user is logged in' do
      it 'returns the conversations list count' do
        subject
        expect(json[:conversations].count).to eq(2)
      end
    end

    it 'returns the conversations list' do
      subject
      expect(json[:conversations].pluck(:id)).to eq expected_conversations.reverse.pluck(:id)
      expect(json[:conversations].pluck(:messages).as_json(except: :user)).to eq(
        expected_messages.reverse.as_json(except: %i[user_id conversation_id updated_at])
      )
      expect(json[:conversations].pluck(:messages).flatten.pluck(:user).pluck(:id)).to include(
        *expected_messages.as_json.flatten.pluck('user_id')
      )
    end

    context 'when the second user is logged in' do
      let(:auth_headers) { second_user.create_new_auth_token }

      it 'returns the conversations list count' do
        subject
        expect(json[:conversations].count).to eq(1)
      end
    end

    context 'when the third user is logged in' do
      let(:auth_headers) { second_user.create_new_auth_token }

      it 'returns the conversations list count' do
        subject
        expect(json[:conversations].count).to eq(1)
      end
    end
  end

  context 'when the request is not valid' do
    context 'when the user is not logged in' do
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
