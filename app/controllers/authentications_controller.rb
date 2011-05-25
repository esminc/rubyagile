class AuthenticationsController < ApplicationController
  def new
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
    flash[:notice] = "Authentication successful."
    session[:user_id] = user.id
    redirect_to root_path
  rescue Exception => e
    render :text => "<html><body><pre>" + e.to_s + "</pre><hr /><pre>" + e.backtrace.join("\n") + "</pre></body></html>"
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to root_path
  end
end
