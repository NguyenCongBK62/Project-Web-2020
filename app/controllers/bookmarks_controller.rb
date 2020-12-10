class BookmarksController < ApplicationController
    before_action :authenticate_user!

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    if @bookmark.save
      @article = @bookmark.article
      @is_bookmarked = @bookmark
      respond_to :js
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @article = @bookmark.article
    if @bookmark.destroy
      respond_to :js
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  private
  def bookmark_params
    params.permit :user_id, :article_id
  end
end
