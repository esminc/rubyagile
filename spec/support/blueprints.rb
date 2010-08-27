Sham.define do
  login { Faker::Internet.user_name }
  email { Faker::Internet.email }
  open_id_url { "http://#{Faker::Internet.domain_name}" }
  link { "http://#{Faker::Internet.domain_name}" }
  content { Faker::Lorem.sentence }
  title { Faker::Lorem.sentence }
  datetime {|i| DateTime.new(2010, 1, i.succ) }
end

Page.blueprint do
  user
  content
end

User.blueprint do
  login
  email
  open_id_url
end

Article.blueprint do
  title
  user
end

KarekiEntry.blueprint do
  title
  creator { Sham.login }
  link
  published_at { Sham.datetime }
end

KarekiFeed.blueprint do
  url { Sham.link }
end
