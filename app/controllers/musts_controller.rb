class MustsController < ApplicationController

  def index
    @musts = current_user.musts
  end
  
  def new
    @user = current_user
    @must = Must.new(params[:must])
  end

  def create
    @must = Must.new(params[:must])
    @must.user = current_user
    if @must.save
      flash[:notice] = "Awesome, one more thing they must do!"
      render :action => "index"
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify your information and try again."
      render :action => "new"
    end
  end
  
  def show
    @comment = Comment.new
    @must = current_user.musts.find_by_id(params[:id])
  end
  
end
