class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article =  Article.new(article_params)
      if @article.save
        flash[:notice] = "Article was successfully saved"
        redirect_to article_path(@article)
      else
        render 'new'
      end
  end
  
  #Edit an article 
  def edit
    @article = Article.find(params[:id])
  end
  
  #Create update action
  def update
    @article = Article.find(params[:id])
      if @article.update(article_params)
        flash[:notic] = "Article was successfully updated"
        redirect_to article_path(@article)
      else
        render 'edit' 
      end
  end
  
  #Defining the method
  def article_params
    params.require(:article).permit(:title, :description)  
  end
  
  #Define the show action 
  def show 
    @article = Article.find(params[:id])
  end
  
  #Define the delete action
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was successfully deleted"
    redirect_to articles_path
  end
  
end