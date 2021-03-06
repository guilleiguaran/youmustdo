class Facebook::UsersController < ApplicationController
  layout "login"
  
  def new
    @user = User.new({
      :facebook_uid => session[:facebook_session][:facebook_uid],
      :email => session[:facebook_session][:email],
      :fb_access_token => session[:facebook_session][:fb_access_token]
    })
    flash[:success] = "You have succesfully signed in with facebook."
  end

  def create
    password = User.random_string(10)
    @user = ::User.new params[:user].update({
      :facebook_uid => session[:facebook_session][:facebook_uid],
      :email => session[:facebook_session][:email],
      :fb_access_token => session[:facebook_session][:fb_access_token],
      :password => password,
      :password_confirmation => password
    })
    @user.avatar_type = 1
    if @user.save
      @user.confirm_email!
      sign_in(@user)
      clear_facebook_session
      flash[:success] = "You have succesfully signed up with facebook."
      redirect_to root_path
    else
      flash[:error] = "Oops, please try again"
      render :action => 'new'
    end
  end

  private

  def clear_facebook_session
    session[:facebook_session]  = nil
  end
end
