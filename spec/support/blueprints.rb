Sham.define do
  login { Forgery::Name.full_name }
  email { Forgery::Internet.email_address }
  url { "http://#{Forgery::Internet.domain_name}" }
  title { Forgery::LoremIpsum.title }
  content { Forgery::LoremIpsum.sentence }
  datetime {|i| DateTime.new(2010, 1, i.succ) }
end

Page.blueprint do
  name { 'FrontPage' }
  user
  content
end

Authentication.blueprint do
  provider { 'twitter' }
  uid { '12345' }
end

User.blueprint do
  login
  email
end

Article.blueprint do
  title
  body { Sham.content }
  user
end

KarekiEntry.blueprint do
  title
  creator { Sham.login }
  content
  published_at { Sham.datetime }
  confirmation { 'confirmed' }
end

KarekiFeed.blueprint do
  url
end
