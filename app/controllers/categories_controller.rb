class CategoriesController < ApplicationController
  before_action :admin_only, except: [:index, :show]
  before_action :set_category, only: [:edit, :update, :show]
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category successfully created"
      redirect_to @category
    else
      render 'new'
    end
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category name successfully updated"
      redirect_to @category
    else
      render 'edit'
    end
  end
  
  private
    def category_params
      params.require(:category).permit(:name)
    end

    def admin_only
      unless (logged_in? && current_user.admin)
        flash[:warning] = "Only admins can perform that action"
        redirect_to categories_path
      end
    end

    def set_category
      @category = Category.find(params[:id])
    end
  
end