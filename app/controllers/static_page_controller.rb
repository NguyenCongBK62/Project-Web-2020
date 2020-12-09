class StaticPageController < ApplicationController
  def home
    @article = Article.new
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      redirect_to articles_path
    end
  end
end
