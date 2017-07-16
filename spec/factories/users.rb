FactoryGirl.define do  
  factory :user do
    name Faker::Name.first_name
    sequence(:email) { |n| "user_#{n}@factory.com" }
    password Faker::Internet.password
    password_confirmation Faker::Internet.password
    role :standard
    confirmed_at Time.now
  end
end
