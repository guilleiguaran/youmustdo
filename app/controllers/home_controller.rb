class HomeController < ApplicationController
  layout "must"
  
  def index
    @musts = Must.find(:all, :order => "created_at desc", :limit => '5')
    @date = Must.last.created_at
  end
  
end