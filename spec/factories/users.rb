FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "factory-user#{n}" }
    key { name }
    email { "#{name}@example.com" }
    password { 'password' }
    confirmed_at { Time.now }
  end
end
