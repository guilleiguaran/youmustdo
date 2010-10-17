class SearchController < ApplicationController
  
  layout :get_layout
  
  def index
    search = params[:search].nil? ? "" : params[:search]
    @users = User.find(:all, 
    :conditions => ["email_confirmed = 1 and (email like ? or username like ? or screen_name like ?)", "%#{search}%", "%#{search}%", "%#{search}%"])
  end
end
