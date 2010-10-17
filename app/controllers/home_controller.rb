class HomeController < ApplicationController
  
  before_filter :load_recent
  layout "dashboard"
  
  def index
  end
  
end