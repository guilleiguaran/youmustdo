# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Authentication
  layout "must"
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def redirect_to_home
    redirect_to root_path 
  end

  def redirect_home_if_signed_in
    redirect_to_home if signed_in?
  end
  
  def login_required
    unless signed_in?
      flash[:error]="Sorry, You must be logged"
      redirect_to sign_in_path 
    end
  end
  
end
