class CommentsController < ApplicationController
  allow_unauthenticated_access only: %i[index]

  def index
    @post = Post.find(params[:post_id])
    render json: @post.comments.includes(:user).map { |c|
      { id: c.id, body: c.body, author: c.user.full_name, created_at: c.created_at }
    }
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user: Current.user))
    if @comment.save
      render json: { id: @comment.id, body: @comment.body, author: Current.user.full_name, created_at: @comment.created_at }, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    render json: { message: "Comment deleted" }
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
