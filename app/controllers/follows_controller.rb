class FollowsController < ApplicationController
  before_filter :login_required
  
  def followers
    @followers = current_user.followers
  end
  
  def followings
    @following = current_user.followings
  end
  
  def follow
    @user = User.find(:user_id)
    unless current_user.following?(@user)
      flash[:notice] = "You are following to #{@user.username}"
    else
      flash[:error] = "You are following to #{@user.username} already"
    end
    
    respond_to do |wants|
      wants.js
    end
  end

  def unfollow
    @user = User.find(:user_id)
    if current_user.following?(@user)
      flash[:notice] = "You aren't following to #{@user.username} anymore"
    else
      flash[:error] = "You aren't following to #{@user.username}"
    end
    respond_to do |wants|
      wants.js
    end
  end

end
