class CommentsController < ApplicationController

  def new
  end

  def create
    #@comment = Comment.new(params[:comment])
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.create(comment_params)
    #@comment = @post.comments.create(params[:comment])
    #@comment.user_id = current_user.id
    if @comment.save
  	 flash[:notice] = 'Comment added'
  	 redirect_to post_path(@post)
    else 
     flash.now[:danger] = "error"
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to(@comment.post)
  end

  private
  def comment_params
  	params.require(:comment).permit(:name, :email, :body, :post_id)
  end

end
