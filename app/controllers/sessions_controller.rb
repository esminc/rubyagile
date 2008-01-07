class SessionsController < ApplicationController

  def create
    open_id_authentication
  end

  protected
  def open_id_authentication
    authenticate_with_open_id do |status, open_id_url|
      if status.successful?
        if @current_user = User.find_by_open_id_url(open_id_url)
          successful_login
        else
          redirect_to new_user_url(:open_id_url => open_id_url)
          return
        end
      else
        failed_login result.message
      end
    end
  end

  private
  def successful_login
    session[:user_id] = @current_user.id
    redirect_to(root_url)
  end

  def failed_login(message)
    flash[:error] = message
    redirect_to(new_session_url)
  end
end
