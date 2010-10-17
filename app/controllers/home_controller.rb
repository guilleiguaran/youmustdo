class HomeController < ApplicationController
  
  before_filter :load_recent
  layout "must"
  
  def index
  end
  
end