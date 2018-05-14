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
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "#{@category.title} added!"
      redirect_to category_path(@category)
    else
      if category_params[:title] == ""
        flash[:notice] = 'You must enter a title for your category!'
      else
        flash[:notice] = "That category already exists"
      end
      redirect_to new_category_path
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy

    flash[:success] = "#{category.title} was successfully deleted!"
    redirect_to categories_path
  end

  private
    def category_params
      params.require(:category).permit(:title)
    end
end
