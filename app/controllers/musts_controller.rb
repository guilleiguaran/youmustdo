class MustsController < ApplicationController
  
  def new
    @user = current_user
    @must = Must.new(params[:project])
  end
end
