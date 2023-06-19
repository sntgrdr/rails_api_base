# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  topic_id   :bigint
#  user_id    :bigint
#  title      :string           not null
#  radius     :decimal(8, 2)    default(0.0), not null
#  latitude   :decimal(10, 6)   default(0.0), not null
#  longitude  :decimal(10, 6)   default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
require 'rails_helper'

RSpec.describe Target, type: :model do
  describe 'associations' do
    subject { build(:target) }

    it { should belong_to(:topic) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    subject { build(:target) }

    it { should validate_presence_of(:radius) }
    it {
      should validate_numericality_of(:radius)
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(1000)
    }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:latitude) }
    it { should validate_numericality_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_numericality_of(:longitude) }
  end
end
