class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.includes(:user).order("created_at desc")
    @article = Article.new
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @photos = @article.photos
    @likes = @article.likes.includes(:user)
    @comment = Comment.new
    @is_liked = @article.is_liked(current_user)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.build(article_params)
    @article.images.attach(params[:article][:images])
    if @article.save
      redirect_to articles_path
      flash[:notice] = "Saved ..."
    else
      flash[:alert] = "Something went wrong ..."
      redirect_to articles_path
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    if @article.user == current_user
      @article.destroy
      flash[:success] = "article deleted"
      redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:content, :images)
    end
end
