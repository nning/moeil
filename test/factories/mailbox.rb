FactoryGirl.define do
  factory :mailbox do
    username { Faker::Internet.user_name }
    password { Faker::Lorem.words.join(' ') }
    name { Faker::Name.name }
    association :domain
  end
end
