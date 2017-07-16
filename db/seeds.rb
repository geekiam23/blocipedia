require 'faker'

# Create Users
20.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(8),
    confirmed_at: Time.now
  )
end

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

users = User.all

# Create public Wikis
50.times do
  Wiki.create!(
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph,
    user: users.sample,
    private: false
  )
end

# Create private wikis
10.times do
	wiki = Wiki.create!(
		title: Faker::Lorem.sentence,
		body: Faker::Lorem.paragraph(15),
		user: users.sample,
		private: true
	)
end

  wikis = Wiki.all

# Create Collabs
30.times do
  Collaborator.create!(
    user_id:  users.sample,
    wiki_id:  wikis.sample
  )
end

  puts "Seed finished"
  puts "#{User.count} users created"
  puts "#{Wiki.count} wikis created"
  puts "#{Collaborator.count} collaborators created"
