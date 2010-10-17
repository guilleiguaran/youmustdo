# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Authentication
  layout "must"
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def load_recent
    @musts_recent = Must.find(:all, :order => "created_at desc", :limit => '5')
    @date = Must.last.created_at
  end
  
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
  

  protected

  def check_valid_user
  
    user = User.find(params[:id]) 
    unless user.nil?
      if signed_in?
        if user != current_user
         flash[:error] = "Ouch sorry, Something's not right, please verify your information and try again."
         redirect_to root_path
        end
      end
    else
      render(:file => "#{RAILS_ROOT}/public/404.html", :head => 404)
    end
  end

end
