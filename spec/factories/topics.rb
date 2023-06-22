# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :topic do
    name { Faker::Hobby.unique.activity }
    after(:build) do |topic|
      topic.image.attach(io: File.open('spec/fixtures/images/test.png'), filename: 'test.png')
    end
  end
end
