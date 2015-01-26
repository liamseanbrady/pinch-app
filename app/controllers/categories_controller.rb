class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :show]
  before_action :require_admin, only: [:new, :create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = 'A new category was created'
      redirect_to goals_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'You updated your category'
      redirect_to root_path
    else
      render :edit
    end
  end

  def show; end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find_by(slug: params[:id])
  end
end