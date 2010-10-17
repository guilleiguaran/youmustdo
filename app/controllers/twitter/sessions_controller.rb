class Twitter::SessionsController < ApplicationController
  before_filter :redirect_home_if_signed_in, :only => [:new]
  layout "login"
  
  def create
    session[:return_after_oauth] = request.referrer
    begin
      oauth.set_callback_url(twitter_session_url)
    rescue Exception => ex
      flash[:error] = "There was a problem connecting to your account. Twitter said: " + ex.message + ". Please try again."
      redirect_to session[:return_after_oauth]
      return
    end
    session[:rtoken]  = oauth.request_token.token
    session[:rsecret] = oauth.request_token.secret
    redirect_to oauth.request_token.authorize_url
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end
  

  def connect
    if params[:oauth_verifier].blank?
      flash[:error] = "Twitter access was denied"
      redirect_to session[:return_after_oauth]
      return
    end
    
    begin
      oauth.authorize_from_request(session[:rtoken], session[:rsecret], params[:oauth_verifier])
    rescue Exception => ex
      flash[:error] = "There was a problem connecting to your account. Twitter said: " + ex.message + ". Please try again."
      redirect_to session[:return_after_oauth]
      return
    end

    # Making things a bit more secure
    clear_twitter_cookie

    profile = Twitter::Base.new(oauth).verify_credentials
    user    = User.find_by_twitter_id(profile.id)
    unless signed_in?
      unless user
        session[:twitter_session] = {
          :id => profile.id,
          :name => profile.name,
          :screen_name => profile.screen_name,
          :access_token => oauth.access_token.token,
          :access_secret => oauth.access_token.secret,
          :avatar_url => profile.profile_image_url
        }
        redirect_to new_twitter_users_path
      else
        user.update_attributes({
          :access_token => oauth.access_token.token,
          :access_secret => oauth.access_token.secret,
          :avatar_url => profile.profile_image_url
        })
        flash[:success] = "You have succesfully logged in with twitter."
        sign_in(user) 
        redirect_to root_path
      end
    else
      unless user
        current_user.update_attributes(:twitter_id => profile.id,
                                      :screen_name => profile.screen_name,
                                      :access_token => oauth.access_token.token,
                                      :access_secret => oauth.access_token.secret,
                                      :avatar_url => profile.profile_image_url)
        redirect_to root_path
      else
        flash[:error] = "Sorry, but that twitter account is already taken!"
        redirect_to user_path(current_user)
      end
    end
  end

  private

  def clear_twitter_cookie
    session[:rtoken]  = nil
    session[:rsecret] = nil
  end

  def oauth
    puts TWITTER_AUTH['key']
    puts TWITTER_AUTH['secret']
    @oauth ||= Twitter::OAuth.new(TWITTER_AUTH['key'], TWITTER_AUTH['secret'], :sign_in => true)
    puts @oauth.inspect
    @oauth
  end
end