class PostsController < ApplicationController

  def index

    @page_title = 'Posts'

    @posts = Post.all
    @categories = Category.all
    @users = User.all

    if params[:search]
    @posts = Post.search(params[:search]).all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
#    else
#    @posts = Post.all.order('created_at DESC').includes(:user).paginate(:per_page => 10, :page => params[:page]) 
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new(:post => @post)
#   @posts = Post.all
#   @users = User.all
  	@categories =Category.all
#  	@comment = Comment.new
#  	@comments = Comment.all
  end

end
