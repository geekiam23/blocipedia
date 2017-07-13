require 'faker'

# Create Users
20.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
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

# Create public Wikis
50.times do
    Wiki.create!(
      title:  Faker::Lorem.sentence,
      body:   Faker::Lorem.paragraph,
      user: users.sample,
      private: false
    )
  end

# Create private Wikis
50.times do
    Wiki.create!(
      title:  Faker::Lorem.sentence,
      body:   Faker::Lorem.paragraph,
      private: true
    )
  end
  Wikis = Wiki.all

# No private wikis for Standard users.
  users.each do |user|
    if user.standard?
      user.wikis.each do
        w.private = false
          w.save
      end
    end
  end

  puts "Seed finished"
  puts "#{User.count} users created"
  puts "#{Wiki.count} wikis created"
