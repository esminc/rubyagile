require 'openid/store/filesystem'

Rails.configuration.middleware.use Rack::OpenID, OpenID::Store::Filesystem.new(Rails.root + 'tmp/openid')
OpenID::Util.logger = Rails.logger

Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :openid
  manager.failure_app = SessionsController

  manager.serialize_from_session do |keys|
    klass, id = keys
    klass.constantize.find_by_id(id)
  end
end

Warden::OpenID.configure do |config|
  config.user_finder do |response|
    User.find_by_open_id_url(response.identity_url)
  end
end
