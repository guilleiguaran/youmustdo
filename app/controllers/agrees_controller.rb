class AgreesController < ApplicationController
  before_filter :login_required
  def agree
    @must = Must.find(params[:must_id])
    @agree = Agree.create(:user_id => current_user.id, :must_id => @must.id, :calification => 1)
    if @agree.save
      flash[:notice] = "Agreed!"
    else
      flash[:error] = "You have already Rank this Must before"
    end
    respond_to do |wants|
      wants.html { redirect_to musts_path }
      wants.js
    end
  end

  def disagree
    @must = Must.find(params[:must_id])
    @agree = Agree.create(:user_id => current_user.id, :must_id => @must.id, :calification => -1)
    logger.info @must.inspect
    if @agree.save
      flash[:notice] = "Disagreed!"
    else
      flash[:error] = "You have already Rank this Must before"
    end
    respond_to do |wants|
      wants.html { redirect_to musts_path }
      wants.js
    end
  end

end
