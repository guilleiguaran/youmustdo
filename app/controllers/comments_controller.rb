class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.must_id = params[:must_id]
    if @comment.save
      flash[:notice] = "There you go, you just commented this must!"
      redirect_to must_path(@comment.must)
    else
      flash[:error] = "Ouch sorry, Something's not right down there, please verify your information and try again."
      render :action => "new"
    end
  end

  def update
  end

  def destroy
  end

end
