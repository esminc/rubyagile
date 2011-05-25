class AuthenticationsController < ApplicationController
  def new
    @authentications = current_user.authentications if current_user
  end

  def create
    raise request.env["omniauth.auth"].to_yaml
    auth = request.env["rack.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
    flash[:notice] = "Authentication successful."
    session[:user_id] = user.id
    redirect_to authentications_url
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
