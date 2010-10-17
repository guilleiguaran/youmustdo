class HomeController < ApplicationController
  
  before_filter :load_recent
  layout "must"
  
  def index
  end
  
  def recent
    @musts = Must.find(:all, :order => "created_at DESC", :limit => 10)
  end
  
end