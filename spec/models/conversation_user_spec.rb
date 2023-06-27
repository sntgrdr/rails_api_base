# == Schema Information
#
# Table name: conversation_users
#
#  id              :bigint           not null, primary key
#  conversation_id :bigint
#  user_id         :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_conversation_users_on_conversation_id  (conversation_id)
#  index_conversation_users_on_user_id          (user_id)
#
require 'rails_helper'

RSpec.describe ConversationUser, type: :model do
  describe 'associations' do
    it { should belong_to(:conversation) }
    it { should belong_to(:user) }
  end
end
