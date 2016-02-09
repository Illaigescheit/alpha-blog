class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  
  def create
    #render plain: params[:article].inspect
    @article =  Article.new(article_params)
    @article.save
    redirect_to_articles_show(@article)
  end
  
  #Defining the method
  def article_params
    params.require(:article).permit(:title, :description)  
  end
  
end