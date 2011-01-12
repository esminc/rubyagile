class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def login_required
    return true if authenticated?

    redirect_to new_session_path
    false
  end
end
