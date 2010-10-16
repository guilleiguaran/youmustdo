class Facebook::SessionsController < ApplicationController

  def new
    options = {
      :redirect_uri => facebook_connect_url,
      :scope => 'email,read_stream,publish_stream,offline_access',
      :display => 'popup'
    }
    redirect_to oauth.web_server.authorize_url(options)
  end

  def create
    if params[:code].nil?
      flash[:error] = params[:error_description] || "Facebook account wasn't authorized."
    else
      access_token = oauth.web_server.get_access_token(params[:code], :redirect_uri => facebook_connect_url)
      facebook_user = JSON.parse(access_token.get('/me'))
      if facebook_user['id'].blank?
        flash[:error] = "There was a problem linking your facebook account. Please try again."
        @redirect_to = sign_in_path
      else
        user = User.find_by_facebook_uid(facebook_user['id'])
        unless user
          session[:facebook_session] = {
            :facebook_uid => facebook_user['id'],
            :email => facebook_user['email']
          }
          @redirect_to = new_facebook_users_path
        else
          flash[:success] = "You have succesfully signed in with facebook."
          sign_in(user) 
          @redirect_to = root_path
        end
      end
    end

    render :partial => "facebook_callback"
  end

  private

  def oauth
    @oauth ||= OAuth2::Client.new(FACEBOOK['app_id'], FACEBOOK['app_secret'], :site => "https://graph.facebook.com")
  end
end