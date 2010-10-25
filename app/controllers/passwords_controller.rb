class PasswordsController < Clearance::PasswordsController
  layout "login"
  
  def create
    if user = ::User.find_by_email(params[:password][:email].downcase)
      user.forgot_password!
      ::ClearanceMailer.change_password(user).deliver
      flash_notice_after_create
      redirect_to(url_after_create)
    else
      flash_failure_after_create
      render :template => 'passwords/new'
    end
  end
  
end
