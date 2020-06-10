class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).order('created_at DESC')
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(white_list_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "successfully created"
      redirect_to @article
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @article.update(white_list_params)
      flash[:success] = "Article was updated succesfully"
      redirect_to @article
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def white_list_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:danger] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end
end