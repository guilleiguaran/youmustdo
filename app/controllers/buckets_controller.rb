class BucketsController < ApplicationController

  before_filter :check_valid_user
  before_filter :login_required, :only =>[:create, :destroy]
    
  def create
    bucket = Bucket.new
    bucket.user_id = current_user.id
    bucket.must_id = params[:must_id]
    if bucket.save
      # flash[:notice] = "You just add this Must to your Bucket List"
      render :update do |page|
        page << "alert('bucket created')"
      end
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify and try again."
      render :update do |page|
        page << "alert('Error, bucket not created')"
      end
    end
  end

  def destroy
    bucket = Bucket.find_by_user_id_and_must_id(current_user.id, params[:must_id])
    if bucket.destroy
      # flash[:notice] = "Must was succesfully deleted from your Bucket List"
      render :update do |page|
        page << "alert('bucket deleted')"
      end
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify and try again."
      render :update do |page|
        page << "alert('Error, bucket not deleted')"
      end
    end
  end

end
