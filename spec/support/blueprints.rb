Sham.define do
  login { Faker::Internet.user_name }
  email { Faker::Internet.email }
  open_id_url { "http://#{Faker::Internet.domain_name}" }
  content { Faker::Lorem.sentence }
end

Page.blueprint do
  content
end

User.blueprint do
  login
  email
  open_id_url
end
