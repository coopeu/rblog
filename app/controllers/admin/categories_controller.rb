class Admin::CategoriesController < Admin::ApplicationController

  def index
    @page_title = 'admin categories'
    if params[:search]
    @categories = Category.search(params[:search]).all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
    else
    @categories = Category.all.order('name ASC').paginate(:per_page => 10, :page => params[:page])
    end
  end

  def new
    page_title = 'Add Category'
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save 
      flash[:notice] = 'Created a new category successfully' 
      redirect_to admin_categories_path
    else
      flash[:alert] = 'Failed creation of a new category' 
      render 'new'
    end
  end

  def edit
    page_title = 'Edit Category'
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
    flash[:notice] = 'Updated category successfully' 
      redirect_to admin_categories_path
    else
      flash[:alert] = 'Failed category updated' 
      render 'edit'
    end  
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice] = 'Category removed'
      redirect_to admin_categories_path
    else
      render 'index'
    end
  end

private
  def category_params
    params.require(:category).permit(:name)
  end

end
