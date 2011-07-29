# coding:utf-8
RailsAdmin.config do |config|
  config.default_items_per_page = 100
  config.current_user_method { current_user }
  config.authenticate_with { signed_in? }
  config.authorize_with {
    unless current_user
      flash[:error] = '権限がありません'
      redirect_to '/'
    end
  }
end
