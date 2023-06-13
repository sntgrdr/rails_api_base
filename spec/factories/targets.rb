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
FactoryBot.define do
  factory :target do
    title     { Faker::Hobby.activity }
    radius    { Faker::Number.between(from: 1.0, to: 1000.0) }
    longitude { Faker::Number.between(from: 1.0, to: 1000.0) }
    latitude  { Faker::Number.between(from: 1.0, to: 1000.0) }
    topic
    user
  end
end
