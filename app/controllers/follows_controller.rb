class FollowsController < ApplicationController
  before_filter :login_required
  
  def followers
    
  end
  
  def followings
    
  end
  
  def follow
    @user = User.find(:user_id)
  end

  def unfollow
    @user = User.find(:user_id)
  end

end
