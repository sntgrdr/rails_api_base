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
class Target < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  validates :radius, presence: true,
                     numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :title, presence: true
  validates :latitude, :longitude, presence: true, numericality: true
end