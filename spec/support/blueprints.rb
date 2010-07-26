Sham.define do
  login { Faker::Internet.user_name }
  email { Faker::Internet.email }
  open_id_url { "http://#{Faker::Internet.domain_name}" }
  link { "http://#{Faker::Internet.domain_name}" }
  content { Faker::Lorem.sentence }
  title { Faker::Lorem.sentence }
end

Page.blueprint do
  content
end

User.blueprint do
  login
  email
  open_id_url
end

Article.blueprint do
  title
end

KarekiEntry.blueprint do
  title
  creator { Sham.login }
  link
end

KarekiFeed.blueprint do
end
