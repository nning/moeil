FactoryGirl.define do
  factory :domain do
    name { Faker::Internet.domain_name }
  end
end
