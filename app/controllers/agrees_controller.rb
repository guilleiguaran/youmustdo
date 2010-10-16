class AgreesController < ApplicationController

  def agree
    @agree = Agree.find(:first, :conditions => {:user_id => current_user.id, :must_id => params[:must_id]})
    if @agree.nil?
      Agree.create(:user_id => current_user.id, :must_id => params[:must_id], :calification => true)
      flash[:notice] = "You Agreed"
    else
      if @agree.calification == 0
         @agree.update_attribute('calification', true)
        flash[:notice] = "You Agreed"
      else
        flash[:error] = "You has already Agreed this must"
      end
    end
    redirect_to musts_path
  end

  def disagree
    @agree = Agree.find(:first, :conditions => {:user_id => current_user.id, :must_id => params[:must_id]})
    if @agree.nil?
      Agree.create(:user_id => current_user.id, :must_id => params[:must_id], :calification => false)
      flash[:notice] = "You Disagree"
    else
      if @agree.calification == 0
         flash[:error] = "You has already disagreed this must"
      else
        @agree.update_attribute('calification', false)
        flash[:notice] = "You Disagree"
      end
    end
    redirect_to musts_path
  end

end
