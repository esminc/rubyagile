# -*- coding: utf-8 -*-
class AuthenticationsController < ApplicationController
  protect_from_forgery :except => :create

  def new
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]

    if omniauth["provider"] && omniauth["uid"]
      auth = Authentication.find_by_provider_and_uid(omniauth["provider"].to_s, omniauth["uid"].to_s)
      if auth
        session[:user_id] = auth.user.id
        flash[:notice] = "ログインに成功しました"
      elsif current_user
        Authentication.create!(:provider => omniauth["provider"], :uid => omniauth["uid"].to_s, :user_id => current_user.id)
        flash[:notice] = "アカウントにサービスを紐づけました"
      else
        flash[:error] = "アカウントにサービスを紐づける場合は一度ログインしてからアカウントの紐付けを実行して下さい。"
      end
    else
      flash[:error] = "ログインに失敗しました"
    end
    redirect_to root_path
  end

  def destroy
    if current_user.authentications.count > 1
      authentication = current_user.authentications.find(params[:id])
      authentication.destroy
      flash[:notice] = "ログインアカウントの紐付けを削除しました"
    else
      flash[:error] = "ログインアカウントの紐付けが一つの場合は削除できません"
    end

    redirect_to signin_path
  end

  def signout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end
end
