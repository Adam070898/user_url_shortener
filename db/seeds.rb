require 'faker'
require 'securerandom'
counter = 1
5.times do
  User.create(full_name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.domain_suffix)
end
User.all.each do |user|
  3.times do
    Url.create(
      user_id: user.id,
      long_url: Faker::Internet.url,
      short_url: SecureRandom.hex(4),
      clicks: 0
      )
  end
end




