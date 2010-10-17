class HomeController < ApplicationController
  
  layout :get_layout
  
  def index
    #Must.refresh_top_musts
    # @musts = Must.find(:all, :conditions => ["top = ?", true], :order => "top_value DESC")
    # @musts_recent = Must.find(:all, :order => "created_at desc", :limit => '5')
    @musts = Must.paginate :page => params[:page], :per_page => 20, :conditions => ["top = ?", true], :order => 'top_value DESC'

  end

  def privacy
    render :layout => "login"
  end

  def terms
    render :layout => "login"
  end
  
  def about
    render :layout => "login"
  end
end