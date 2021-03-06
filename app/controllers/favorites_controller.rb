class FavoritesController < ApplicationController
  
  def index
    @musts = current_user.favorite_musts.paginate :page => params[:page], :per_page => 20, :order => 'created_at DESC'
    respond_to do |wants|
      wants.html
    end
  end
  
  def favorite
    @must = Must.find(params[:must_id])
    current_user.has_favorite(@must)
    respond_to do |wants|
      wants.html{ redirect_to :back }
      wants.js
    end
  end
  
  def unfavorite
    @must = Must.find(params[:must_id])
    current_user.has_no_favorite(@must)
    respond_to do |wants|
      wants.html{ redirect_to :back }
      wants.js
    end
  end
  
end