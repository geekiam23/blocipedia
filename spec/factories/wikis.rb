FactoryGirl.define do
  factory :wiki do
    title Faker::App.name
    body Faker::Lorem.paragraph
    user Faker::App.name
  end
end
