# frozen_string_literal: true

class Blog::PublishedPostsController < Blog::BlogController
  before_action :authenticate_user!

  def index
    @search = params[:search]
    @posts = requested_published_posts
  end

  def update
    @post = Post.find(params[:id])
    @new_state = params[:new_state]
    update_post_state(@post, @new_state) if @new_state
    @posts = requested_published_posts
  end

  private

  def requested_published_posts
    if params[:search]
      return Post.published.search_titles(params[:search]).page params[:page]
    end
    Post.published.page params[:page]
  end
end
