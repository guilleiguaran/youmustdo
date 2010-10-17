class FavoritesController < ApplicationController
  
  def index
    @favorites = current_user.favorite_musts
    respond_to do |wants|
      wants.js
    end
  end
  
  def create
    current_user.has_favorite(Must.find(params[:must_id]))
    respond_to do |wants|
      wants.html{ redirect_to :back }
      wants.js
    end
  end
  
  def destroy
    current_user.has_no_favorite(Must.find(params[:must_id]))
    respond_to do |wants|
      wants.html{ redirect_to :back }
      wants.js
    end
  end
  
  
end