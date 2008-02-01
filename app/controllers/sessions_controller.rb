class SessionsController < ApplicationController

  # render new.html.erb
  def new; end

  def create
    open_id_authentication
  end

  def destroy
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to(root_path)
  end

  protected
  def open_id_authentication
    authenticate_with_open_id(params[:openid_url],:optional => ["nickname", "email", "fullname"]) do |status, open_id_url, registration|
      if status.successful?
        if @current_user = User.find_by_open_id_url(open_id_url)
          successful_login
        else
          failed_login "You can't log in."
        end
      else
        failed_login result.message
      end
    end
  end

  private
  def successful_login
    tmp_return_to = session[:return_to]
    reset_session
    session[:user_id] = @current_user.id
    session[:return_to] = tmp_return_to
    flash[:notice] = "You Logged in."
    redirect_back_or_default(root_url)
  end

  def failed_login(message)
    flash[:error] = message
    redirect_to(new_session_url)
  end
end
