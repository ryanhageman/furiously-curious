# frozen_string_literal: true

class BlogAdmin::HiddenPostsController < BlogAdminController
  before_action :authenticate_user!
  after_action :verify_authorized, except: %i[index]

  def index
    @search = params[:search]
    @posts = requested_hidden_posts
  end

  def update
    @post = Post.find(params[:id])
    @new_state = params[:new_state]
    authorize @post
    update_post_state(@post, @new_state) if @new_state
    @posts = requested_hidden_posts
  end

  private

  def requested_hidden_posts
    if params[:search]
      return Post.hidden.search_titles(params[:search]).page params[:page]
    end
    Post.hidden.page params[:page]
  end
end
