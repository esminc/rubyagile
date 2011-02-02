Sham.define do
  login { Forgery::Name.full_name }
  email { Forgery::Internet.email_address }
  open_id_url { "http://#{Forgery::Internet.domain_name}" }
  link { "http://#{Forgery::Internet.domain_name}" }
  content { Forgery::LoremIpsum.sentence }
  title { Forgery::LoremIpsum.sentence }
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
  content
  published_at { Sham.datetime }
  confirmation { 'confirmed' }
end

KarekiFeed.blueprint do
  url { Sham.link }
end
