class BucketsController < ApplicationController
  before_filter :login_required, :only =>[:create, :destroy]
  layout :get_layout

  def index
    @buckets = current_user.buckets.paginate :page => params[:page], :per_page => 20, :order => 'created_at DESC'
  end
  
  def update
    @bucket = current_user.buckets.find_by_must_id(params[:must_id])
    if @bucket
      unless @bucket.status
        if @bucket.update_attribute('status', true)
          flash[:success] = "Great! keep like that!, you have already done this one."
        else
          flash[:error] = "Ouch sorry, Something is not right down there, please verify and try again."
        end
      else
        flash[:notice] = "Uhm? You have already done this, Go get done the other Musts."
      end
    end
    respond_to do |wants|
      wants.html{ redirect_to :back }
      wants.js
    end
  end
  
  def create
    @bucket = Bucket.new
    @bucket.user = current_user
    @bucket.must_id = params[:must_id]
    if @bucket.save
      flash[:notice] = "This Must was added to your Bucket List."
    else
      flash[:error] = "Uhm? You Must see your Bucket List, I am pretty sure this Must is already there."
    end
    respond_to do |wants|
      wants.html{ redirect_to :back }
      wants.js
    end  
  end

  def destroy
    @bucket = current_user.buckets.find_by_must_id(params[:must_id])
    @bucket.destroy
    flash[:success] = 'Must was succesfully deleted from your Bucket List'
    respond_to do |wants|
      wants.html{ redirect_to :back }
      wants.js
    end
  end

end
