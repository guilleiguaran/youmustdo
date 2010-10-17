class HomeController < ApplicationController
  
  before_filter :load_recent
  
  def index
    Must.refresh_top_musts
    @musts = Must.find(:all, :conditions => ["top = ?", true], :order => "top_value DESC")
  end
  
  
end