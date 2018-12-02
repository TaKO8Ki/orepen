class LikesController < ApplicationController
  before_action :set_article

    def create
      @like = Like.create(user_id: current_user.id, article_id: params[:article_id])
      @likes = Like.where(article_id: params[:article_id])
      create_notifications
      @article.reload
    end

    def destroy
      like = Like.find_by(user_id: current_user.id, article_id: params[:article_id])
      like.destroy
      @likes = Like.where(article_id: params[:article_id])
      @article.reload
    end

    private

    def set_article
      @article = Article.find(params[:article_id])
    end

    def create_notifications
       return if @article.user.id == current_user.id
       Notification.create(user_id: @article.user.id,
        notified_by_id: current_user.id,
        action_id: @article.id,
        notified_type: 'like')
     end


end
