class WelcomeController < ApplicationController
  layout "home"

  def index
    if params[:query]
      @results = Post.where('title LIKE ?', "%#{params[:query]}%")
    end
    params[:page] || 1
    @posts = Post.includes(:comments).page(params[:page]).per(10)
    @top_posts = Post.top_posts
    @top_tags = Tag.top_tags
  end

  def autocomplete
    render json: Post.where('title ILIKE ?', "%#{params[:query]}%").map {|s| {name: s.title}}
  end
end

