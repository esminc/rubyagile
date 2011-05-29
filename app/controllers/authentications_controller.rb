# -*- coding: utf-8 -*-
class AuthenticationsController < ApplicationController
  protect_from_forgery :except => :create

  def new
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    if omniauth["provider"] && omniauth["uid"] && current_user
      auth = Authentication.find_or_create_by_provider_and_uid(omniauth["provider"], omniauth["uid"].to_s)
      if auth.user
        session[:user_id] = auth.user.id
      else
        auth.update_attributes!({:user_id => current_user.id})
      end
      flash[:notice] = "ログインに成功しました"
    else
      flash[:error] = "ログインに失敗しました。アカウントにサービスを紐づける場合は一度ログインしてからアカウントの紐付けを実行して下さい。"
    end
    redirect_to root_path
  end

  def destroy
    if current_user.authentications.count > 1
      authentication = current_user.authentications.find(params[:id])
      authentication.destroy
      session[:user_id] = nil

      flash[:notice] = "ログインアカウントの紐付けを削除しました"
    else
      flash[:notice] = "ログインアカウントの紐付けが一つの場合は削除できません"
    end

    redirect_to new_authentication_path
  end

  def signout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end
end
