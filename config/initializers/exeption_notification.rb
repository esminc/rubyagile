if Rails.env.production?
  # XXX tig/atig proxy access is raised to ActionView::MissingTemplate
  RubyAgile::Application.config.middleware.use ExceptionNotifier,
    :email_prefix => "[rubyagile] ",
    :sender_address => %{"notifier" <notifier@example.com>},
    :exception_recipients => %w{rubyagile@qwik.tky.esm.co.jp},
    :ignore_exceptions => %w{ActionView::MissingTemplate}
end
