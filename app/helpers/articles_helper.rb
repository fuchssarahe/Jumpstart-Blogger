module ArticlesHelper

  def article_params
    params.require(:article).permit(:title, :body, :tag_list, :image)
  end
  
  def original_author?
    current_article = Article.select {|article| article.id == params[:id].to_i}
    current_article[0].author_id == current_user.id
  end
  
  def deny_unauthorized_access
    if original_author? == false
      flash.notice = "You do not have sufficient privledges to alter this article." 
      redirect_to articles_path
    end
  end
   
end
