class AgreesController < ApplicationController

  def agree
    @agree = Agree.create(:user_id => current_user.id, :must_id => params[:must_id], :calification => 1)
    if @agree.save
      flash[:notice] = "Agreed!"
    else
      flash[:error] = "You have already Agreed this must before"
    end
    respond_to do |wants|
      wants.html { redirect_to musts_path }
      wants.js
    end
  end

  def disagree
    @agree = Agree.create(:user_id => current_user.id, :must_id => params[:must_id], :calification => -1)
    if @agree.save
      flash[:notice] = "Disagreed!"
    else
      flash[:error] = "You have already Disagreed this must before"
    end
    respond_to do |wants|
      wants.html { redirect_to musts_path }
      wants.js
    end
  end

end
