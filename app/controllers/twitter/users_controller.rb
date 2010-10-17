class Twitter::UsersController < ApplicationController
  before_filter :redirect_home_if_signed_in, :only => [:new, :create]

  def new
    @user = User.new({
      :screen_name => session[:twitter_session][:screen_name],
      :username => session[:twitter_session][:screen_name]
    })
    flash[:success] = "You have succesfully logged in with twitter."
    render :template => "twitter/users/new"
    #create
  end

  def create
    create_user
    if @user.save
      @user.confirm_email!
      sign_in(@user)
      clear_twitter_cookie
      flash[:success] = "You have succesfully logged in with twitter."
      redirect_to url_after_create
    else
      flash[:error] = "Oops, please try again"
      render :template => 'twitter/users/new'
    end
  end

  private

  def clear_twitter_cookie
    session[:rtoken]  = nil
    session[:rsecret] = nil
  end

  def url_after_create
    root_path
  end

  def create_user
    password = User.random_string(10)
    @user = ::User.new params[:user]
    @user.avatar_type = 2
    @user.twitter_id    = session[:twitter_session][:id]
    @user.screen_name   = session[:twitter_session][:screen_name]
    @user.access_token  = session[:twitter_session][:access_token]
    @user.access_secret = session[:twitter_session][:access_secret]
    @user.avatar_url = session[:twitter_session][:avatar_url]
    @user.password = password
    @user.password_confirmation = password
  end
end