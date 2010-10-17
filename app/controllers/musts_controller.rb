class MustsController < ApplicationController

  before_filter :login_required, :only => [:create, :new, :edit, :update, :destroy]

  layout :get_layout
  
  include ApplicationHelper

  def index
    @musts = Must.all
  end
  
  def recents
    @musts = Must.find(:all, :order => "created_at DESC", :limit => 10)
  end
  
  def tags
    @musts = Must.tagged_with(params[:tag]).by_creation_date
    @tag = params[:tag]
  end
  
  def my_musts
    @musts = current_user.musts.find(:all, :order => "created_at DESC", :limit => 10)
  end
  
  def user_musts
    @user = User.find_by_username(params[:username])
    @musts = @user.musts.find(:all, :order => "created_at DESC", :limit => 10)
  end

  def new
    @user = current_user
    @must = Must.new(params[:must])
    @must.category_id = params[:category] if params[:category]
    render :layout => 'login'
  end

  def load_more
    @must = Must.last
    @update = true if last_must = @must.created_at > Time.parse(params[:date])
    respond_to do |wants|
      wants.js
    end
  end

  def create
    @must = Must.new(params[:must])
    @must.user = current_user
    if @must.save
      flash[:notice] = "Awesome, one more thing they must do!"
      respond_to do |wants|
        wants.html { redirect_to musts_path }
      end
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify your information and try again."
      respond_to do |wants|
        wants.html { render :action => "new" }
      end
    end
  end

  def edit
    @must = Must.find(params[:id])
  end

  def update
    @must = Must.find(params[:id])
    if @must.update_attributes(params[:must])
      flash[:notice] = "Must edited"
      respond_to do |wants|
        wants.html { redirect_to musts_path }
      end
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify your information and try again."
      respond_to do |wants|
        wants.html { render :action => "edit" }
      end
    end
  end

  def show
    @comment = Comment.new
    @must = Must.find(params[:id])
    render :layout => 'login'
  end

  def destroy
    @must = Must.find(params[:id])
    if @must.destroy
      flash[:notice] = "Must deleted"
      redirect_to musts_path
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify your information and try again."
      render :action => "new"
    end
  end

  def get_url_metadata
    if params[:url]
      data = Metadata.get(params[:url])
      @title = data[0]
      @description = data[1]
      @images      = data[2]
      @videos      = {:url => data[4], :type => data[3]}
      puts data.inspect
      respond_to do |wants|
        wants.js
      end
    end
  end

end
