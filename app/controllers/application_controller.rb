class ApplicationController < ActionController::Base
  include Clearance::Authentication
  layout :get_layout
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def get_layout
    if signed_in?
      "home"
    else
      "landing"
    end
  end

  def redirect_to_home
    redirect_to root_path 
  end

  def redirect_home_if_signed_in
    redirect_to_home if signed_in?
  end


  def login_required
    unless signed_in?
      flash[:error] = "Sorry, You must be logged"
      redirect_to sign_in_path 
    end
  end


  protected

  def check_valid_user
    user = User.find(params[:id]) 
    if user
      if signed_in? && user != current_user
        flash[:error] = "Ouch sorry, Something's not right, please verify your information and try again."
        redirect_to root_path
      end
    else
      render(:file => "#{Rails.root}/public/404.html", :head => 404)
    end
  end

end