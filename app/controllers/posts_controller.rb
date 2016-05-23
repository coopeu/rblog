class PostsController < ApplicationController

  def index

    @page_title = 'Posts'


    if params[:search]
    @posts = Post.search(params[:search]).all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
    else
    @posts = Post.all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
    @categories = Category.all
    end
  end

  def show
  	@post = Post.find(params[:id])
  	@categories =Category.all
  	@comment = Comment.new
  	@comments = Comment.all
  end

end
