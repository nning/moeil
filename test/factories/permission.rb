FactoryGirl.define do
  factory :permission do
    role { 'owner' }
    association :subject, factory: :mailbox
    association :item,    factory: :domain
  end
end
