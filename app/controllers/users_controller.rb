class UsersController < Clearance::UsersController
  before_filter :authenticate, :except => [:new, :create]
  before_filter :check_valid_user, :only => [:profile, :update]

  def new
    @user = ::User.new(params[:user])
    render :layout => "login"
  end

  def profile
    @user = User.find(params[:id])
    render :layout => "login"
  end

  def update_profile
    @user = current_user
    before_name = current_user.username
    before_email = current_user.email

    if @user.update_attributes(params[:user])
      respond_to do |format|
        flash[:success] = "Profile updated successfully."
        format.html { redirect_to user_profile_path(@user) }
      end
    else
      current_user.username = before_name
      current_user.email = before_email
      respond_to do |format|
        flash[:error] = "Error updating the profile."
        format.html { render :action => "profile" }
      end
    end
  end

end