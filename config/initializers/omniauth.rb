require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :linked_in, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end
