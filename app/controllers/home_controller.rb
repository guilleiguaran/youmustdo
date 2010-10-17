class HomeController < ApplicationController
  
  before_filter :load_recent
  layout :get_layout
  
  def index
    #Must.refresh_top_musts
    @musts = Must.find(:all, :conditions => ["top = ?", true], :order => "top_value DESC")
  end

  def privacy
    render :layout => "login"
  end

  def terms
    render :layout => "login"
  end
end