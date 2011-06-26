Fabricator :user do
  login { Forgery::Internet.user_name }
  email { Forgery::Internet.email_address }
  nakanohito true
end

Fabricator :authentication do
  provider 'twitter'
  uid { sequence(:uid, 1000).to_s }
end

Fabricator :article do
  title { Forgery::LoremIpsum.title }
  body  { Forgery::LoremIpsum.sentence }
  publishing true
  user!
end

Fabricator :page do
  name { Forgery::Basic.text }
  content { Forgery::LoremIpsum.sentence }
  user!
end

Fabricator :front_page, from: :page do
  name 'FrontPage'
end

Fabricator :feed, from: :kareki_feed do
  url { "http://#{Forgery::Internet.domain_name}" }

  after_build do |feed|
    feed.stub(:build_feed)
  end
end

Fabricator :entry, from: :kareki_entry do
  title { Forgery::LoremIpsum.title }
  content { Forgery::LoremIpsum.sentence }
  link { "http://#{Forgery::Internet.domain_name}" }
  published_at { DateTime.now }
  creator { Forgery::Name.full_name }
end

Fabricator :confirmed_entry, from: :entry do
  confirmation 'confirmed'
end
