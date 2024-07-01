# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # POST /comments
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'Failed to create comment.'
    end
  end

  # GET /comments/:id/edit
  def edit
    authorize_comment_owner(@comment)
  end

  # PATCH/PUT /comments/:id
  def update
    authorize_comment_owner(@comment)

    if @comment.update(comment_params)
      redirect_to @comment.post, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /comments/:id
  def destroy
    @comment.destroy
    redirect_to @post, notice: 'Comment was successfully deleted.'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def authorize_comment_owner(comment)
    unless comment.user == current_user
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
