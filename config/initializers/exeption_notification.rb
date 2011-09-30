if Rails.env.production?
  RubyAgile::Application.config.middleware.use ExceptionNotifier, :email_prefix => "[rubyagile] ", :sender_address => %{"notifier" <notifier@example.com>}, :exception_recipients => %w{rubyagile@qwik.tky.esm.co.jp}
end
