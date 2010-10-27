class SessionsController < ApplicationController
  def new
  end

  def create
    authenticate!
    successful_login
  end

  def destroy
    logout
    flash[:notice] = "You have been sign out."
    redirect_to root_path
  end

  def unauthenticated
    failed_login warden.message
  end

  private

  def successful_login
    flash[:notice] = "You Sign in."
    redirect_to root_path
  end

  def failed_login(message)
    flash[:error] = message
    render :action => 'new'
  end
end
