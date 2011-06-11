# coding:utf-8
RailsAdmin.current_user_method{ current_user }

RailsAdmin.authenticate_with{ signed_in? }

RailsAdmin.authorize_with {
  unless current_user
    flash[:error] = '権限がありません'
    redirect_to '/'
  end
}

RailsAdmin.config do |config|
  config.list.default_items_per_page = 100
end
