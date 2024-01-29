FactoryBot.define do
  factory :course do
    title { Faker::Book.title }
    video_url { Faker::Internet.url }
    status { Random.rand(0..1) }
  end
end