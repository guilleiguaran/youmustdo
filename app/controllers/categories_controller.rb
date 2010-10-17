class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_name(params[:category])
    if @category.nil?
      render(:file => "#{RAILS_ROOT}/public/404.html", :head => 404)
    else 
      # @musts = @category.musts.find(:all, :order => "created_at DESC", :limit => 10)
      
          @musts = @category.musts.paginate :page => params[:page], :per_page => 20, :order => 'created_at DESC'


    end
  end
end
