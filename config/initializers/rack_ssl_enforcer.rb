if Rails.env.production?
  Rails.application.config.middleware.use Rack::SslEnforcer, :only => ["/auth", "/admin"]
end
