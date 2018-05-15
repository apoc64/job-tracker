class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    if category.save
      flash[:success] = "#{category.title} added!"
      redirect_to category_path(category)
    elsif category_params[:title].empty?
      flash[:notice] = 'You must enter a title for your category!'
      redirect_to new_category_path
    else
      flash[:notice] = "#{category.title} already exists"
      redirect_to new_category_path
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    flash[:success] = "#{category.title} was successfully deleted!"
    redirect_to categories_path
  end

  def edit
    @category = Category.find(params[:id])
  end

  private
    def category_params
      params.require(:category).permit(:title)
    end
end
