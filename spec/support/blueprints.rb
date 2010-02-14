Sham.define do
  content { Faker::Lorem.sentence }
end

Page.blueprint do
  content
end
