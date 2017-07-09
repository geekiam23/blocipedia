require 'faker'

# Create Users
20.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(8),
    confirmed_at: Time.now
  )
end

# Create Wikis
50.times do
    Wiki.create!(
      title:  Faker::Lorem.sentence,
      body:   Faker::Lorem.paragraph
    )
  end
  Wikis = Wiki.all

  admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'password',
  confirmed_at: Time.now,
  role: 'admin'
)

premium = User.create!(
  name: 'Premium User',
  email: 'premium@example.com',
  password: 'password',
  confirmed_at: Time.now,
  role: 'premium'
)

standard = User.create!(
  name: 'Standard User',
  email: 'standard@example.com',
  password: 'password',
  confirmed_at: Time.now,
  role: 'standard'
)

  puts "Seed finished"
  puts "#{User.count} users created"
  puts "#{Wiki.count} wikis created"
