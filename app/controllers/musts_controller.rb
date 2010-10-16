class MustsController < ApplicationController
  before_filter :login_required, :only =>[:create, :new, :edit, :update, :destroy]
  def index
    @musts = Must.all
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
      redirect_to musts_path
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify your information and try again."
      render :action => "new"
    end
  end
  
  def edit
    @must = Must.find_by_id(params[:id])
  end
  
  def update
    @must = Must.find(params[:id])
    if @must.update_attributes(params[:must])
      flash[:notice] = "Must edited"
      redirect_to musts_path
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify your information and try again."
      render :action => "new"
    end
  end
  
  def show
    @comment = Comment.new
    @must = Must.find(params[:id])
  end
  
  def destroy
    @must = Must.find_by_id(params[:id])
    if @must.destroy
      flash[:notice] = "Must deleted"
      redirect_to musts_path
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify your information and try again."
      render :action => "new"
    end
  end
  
end
