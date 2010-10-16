class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_name(params[:category])
    if @category.nil?
      render(:file => "#{RAILS_ROOT}/public/404.html", :head => 404)
    else 
      @musts = @category.musts
    end
  end
end
