class UsersController < ApplicationController
  def index
    @users = User.search(params[:term])
    respond_to :js
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.includes(:images, :likes, :comments)
    @saved = Article.joins(:bookmarks).where(user_id: current_user.id).
      includes(:images, :likes, :comments) if @user == current_user
  end
end
