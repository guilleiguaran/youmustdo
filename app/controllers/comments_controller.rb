class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.must_id = params[:must_id]
    if @comment.save
      flash[:notice] = "There you go, you just commented this must!"
      respond_to do |wants|
        wants.html { redirect_to must_path(@comment.must) }
      end
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify and try again."
      respond_to do |wants|
        wants.html { render :action => "new" }
      end
    end
  end

  def update
  end

  def destroy
    @comment = Comment.find(params[:id])
    must_id = @comment.must_id
    if @comment.destroy
      flash[:notice] = "comment deleted"
      respond_to do |wants|
        wants.html { redirect_to must_path(must_id) }
      end
    else
      flash[:error] = "Something's goes wrong."
      respond_to do |wants|
        wants.html { render :action => "new" }
      end
    end
  end

end
