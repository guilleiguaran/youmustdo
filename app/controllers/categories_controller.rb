class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @musts = @category.musts
  end
end
