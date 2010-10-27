# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '935e963f099051ad538fff1f635764a1'

  private

  def login_required
    return true if authenticated?

    redirect_to new_session_path
    false
  end
end
