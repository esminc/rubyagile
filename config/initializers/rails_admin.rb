# coding:utf-8
RailsAdmin.current_user_method{ current_user }

RailsAdmin.authenticate_with{ signed_in? }

RailsAdmin.authorize_with {
  redirect_to(:root, :alert => '権限がありません') unless current_user
}

RailsAdmin.config do |config|
  config.list.default_items_per_page = 100
end
