class MustsController < ApplicationController
  include ApplicationHelper

  before_filter :login_required, :only => [:create, :new, :edit, :update, :destroy]
  protect_from_forgery :except => :get_url_metadata
  layout :get_layout
  
  def recents
    @musts = Must.paginate :page => params[:page], :per_page => 20, :order => 'created_at DESC'
  end
  
  def tags
    @musts = Must.tagged_with(params[:tag]).by_creation_date.paginate(:page => params[:page], :per_page => 20)
    @tag = params[:tag]
  end
  
  def my_musts
    @musts = current_user.musts.paginate :page => params[:page], :per_page => 20, :order => 'created_at DESC'
  end

  def play
  end
  
  def user_musts
    @user = User.find_by_username(params[:username])
    @musts = @user.musts.paginate :page => params[:page], :per_page => 20, :order => 'created_at DESC'
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
    if params[:attachment]
      @must.build_attachment(params[:attachment]) unless params[:attachment][:file].blank?
    end
    @must.user = current_user
    if @must.save
      @must.should_process #Process attachments
      current_user.post_to_facebook(@must, must_url(@must)) if params[:share][:facebook].eql?("1")
      current_user.post_to_twitter(@must, must_url(@must)) if params[:share][:twitter].eql?("1")
      flash[:notice] = "Awesome, one more thing they must do!"
      respond_to do |wants|
        wants.html { redirect_to must_path(@must) }
      end
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify your information and try again."
      respond_to do |wants|
        wants.html { render :action => "new" }
      end
    end
  end


  def show
    @comment = Comment.new
    @must = Must.find(params[:id])
    render :action => "show"
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
      respond_to do |wants|
        wants.js
      end
    end
  end

end
