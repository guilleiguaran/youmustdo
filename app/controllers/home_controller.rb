class HomeController < ApplicationController
  
  before_filter :load_recent
  layout :get_layout
  
  def index
    Must.refresh_top_musts
    @musts = Must.find(:all, :conditions => ["top = ?", true], :order => "top_value DESC")
  end
  
  private

  def get_layout
    if signed_in?
      "home"
    else
      "landing"
    end
  end
  
end