class BucketsController < ApplicationController

  before_filter :check_valid_user
  before_filter :login_required, :only =>[:create, :destroy]
  layout :get_layout

  def index
    # @buckets = current_user.buckets
            @buckets = current_user.buckets.paginate :page => params[:page], :per_page => 20, :order => 'created_at DESC'

  end

  def update
    bucket = Bucket.find_by_user_id_and_must_id(current_user.id, params[:must_id])
    unless bucket.nil?
      unless bucket.status
        if bucket.update_attribute('status', true)
          render :update do |page|
            page.replace_html "must#{bucket.must.id}", :partial => 'musts/must_item', :locals => {:must => bucket.must}
            page << "$('#bucket_list_tab span').remove()"
            if current_user.bucket_list_count > 0
            page << "$('#bucket_list_tab').append('<span>#{current_user.bucket_list_count}</span>')"
            end
            page << "new_notification('Great! keep like that!, you have already done this one.', 'success')"
          end
        else
          render :update do |page|
            page << "new_notification('Ouch sorry, Something is not right down there, please verify and try again.', 'error')"
          end
        end
      else
        render :update do |page|
          page << "new_notification('Uhm? You have already done this, Go get done the other Musts. :)', 'info')"
        end
      end
    else
      render :update do |page|
        page << "new_notification('Ouch sorry, Something is not right down there, please verify and try again.', 'error')"
      end
    end
  end

  def create
    bucket_check = Bucket.find_by_user_id_and_must_id(current_user.id, params[:must_id])
    if bucket_check.nil?
      bucket = Bucket.new
      bucket.user_id = current_user.id
      bucket.must_id = params[:must_id]
      if bucket.save
        # flash[:notice] = "You just add this Must to your Bucket List"
        render :update do |page|
          page << "new_notification('This Must was added to your Bucket List.', 'success')"
          page << "$('#bucket_list_tab span').remove()"
          page << "$('#bucket_list_tab').append('<span>#{current_user.bucket_list_count}</span>')"
        end
      else
        # flash[:error] = "Ouch sorry, Something's not right down there, please verify and try again."
        render :update do |page|
          page << "new_notification('Ouch sorry, Something is not right down there, please verify and try again.', 'error')"
        end
      end
    else
      render :update do |page|
        page << "new_notification('Uhm? You Must see your Bucket List, I am pretty sure this Must is already there.', 'info')"
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
