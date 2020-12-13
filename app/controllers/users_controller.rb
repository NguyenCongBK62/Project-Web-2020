class UsersController < ApplicationController
  def index
    @users = User.search(params[:term])
    respond_to :js
  end
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page], :per_page => 6)
    render 'show_follow'
  end
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page], :per_page => 6)
    render 'show_follow'
  end
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:photos, :likes, :comments)
    @saved = Post.joins(:bookmarks).where("bookmarks.user_id = ?", current_user.id).
      includes(:photos, :likes, :comments) if @user == current_user
  end

  def list_user
    @users = User.all.paginate(:page => params[:page], :per_page => 6)
    render "list_user"
  end
end