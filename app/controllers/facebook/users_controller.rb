class Facebook::UsersController < ApplicationController

  def new
    @user = User.new({
      :facebook_uid => session[:facebook_session][:facebook_uid],
      :email => session[:facebook_session][:email]
    })
    flash[:success] = "You have succesfully signed in with facebook."
  end

  def create
    @user = ::User.new params[:user].merge({
      :facebook_uid => session[:facebook_session][:facebook_uid],
      :email => session[:facebook_session][:email]
    })
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
