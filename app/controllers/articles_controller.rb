class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article =  Article.new(article_params)
    @article.user = User.find(current_user)
      if @article.save
        flash[:success] = "Article was successfully saved"
        redirect_to article_path(@article)
      else
        render 'new'
      end
  end
  
  #Edit an article 
  def edit
  end
  
  #Create update action
  def update
      if @article.update(article_params)
        flash[:success] = "Article was successfully updated"
        redirect_to article_path(@article)
      else
        render 'edit' 
      end
  end
  
  #Define the show action 
  def show 
  end
  
  #Define the delete action
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  private
  
  #Defining a find method
  def set_article
    @article = Article.find(params[:id])
  end
  
   #Defining the method
  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])  
  end
  
  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You
      can only edit or delete your own articles"
      redirect_to root_path
    end
  end
  
end