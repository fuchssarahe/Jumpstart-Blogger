class ArticlesController < ApplicationController
  include ArticlesHelper
  before_filter :require_login, except: [:index, :show]
  # before_filter :deny_access, :unless => :original_author?, except: [:index, :show, :create] 
  before_filter :deny_unauthorized_access, only: [:edit, :destroy] 
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])  
    
    @article.increment_view_counter
        
    @comment = Comment.new  
    @comment.article_id = @article.id
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.author_id = current_user.id
    @article.save
    
    flash.notice = "Article '#{@article.title}' was sucessfully created!"
    
    redirect_to article_path(@article)
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    
    flash.notice = "Article '#{@article.title}' was sucessfully updated!"
    
    redirect_to article_path(@article)
  end
  
  def destroy
    @article = Article.find(params[:id]).destroy
    
    flash.notice = "Article '#{@article.title}' was sucessfully deleted!"
    
    redirect_to articles_path
  end
  
end
