class CommentsController < ApplicationController
    before_action :authenticate_user!

  def index
    @comments = @article.comments.includes(:user)
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @article = @comment.article
      respond_to :js
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @article = @comment.article
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  private
  def comment_params
    params.required(:comment).permit :user_id, :article_id, :content
  end
end
