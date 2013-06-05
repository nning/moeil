FactoryGirl.define do
  factory :alias do
    username { Faker::Internet.user_name }
    association :domain
    goto { ([0] * (rand(9) + 1)).map { Faker::Internet.email }.join(',') }
  end
end
