class SearchController < ApplicationController
  layout "login"
  
  def index
    search = params[:search].nil? ? "" : params[:search]
    @users = User.find(:all, 
    :conditions => ["email_confirmed = 1 and (email like ? or username like ? or screen_name like ?)", "%#{search}%", "%#{search}%", "%#{search}%"])
  end
end
