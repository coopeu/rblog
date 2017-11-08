class Admin::PostsController < Admin::ApplicationController

  def index
  	@page_title = 'admin posts'
    if params[:search]
    @posts = Post.search(params[:search]).all.order('created_at DESC').paginate(:per_page => 5, :page => params[:page])
    else
    @posts = Post.all.order('created_at DESC').paginate(:per_page => 5, :page => params[:page])
    end
  end

  def new
    page_title = 'Add Post'
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    
    if params[:post][:image].blank?
      @post.image = nil
    end

    if @post.save 
      flash[:notice] = 'Created a new post successfully' 
      redirect_to admin_posts_path
    else
      flash[:alert] = 'Failed creation of a new post' 
      render 'new'
    end
  end

  def edit
    page_title = 'Edit Post'
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if params[:post][:image].blank?
      @post.image = nil
    end
    
    if @post.update(post_params)
    flash[:notice] = 'Updated post successfully' 
      redirect_to admin_posts_path
    else
      flash[:alert] = 'Failed post updated'
      render 'new'
    end  
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Post removed'
      redirect_to admin_posts_path
    else
      render 'index'
    end
  end

private
  def post_params
    params.require(:post).permit(:title, :category_id, :user_id, :image, :tags, :body)
  end

end
