# frozen_string_literal: true

class Blog::DraftsController < Blog::BlogController
  before_action :authenticate_user!

  def index
    @search = params[:search]
    @posts = requested_drafts
  end

  def update
    @post = Post.find(params[:id])
    @new_state = params[:new_state]
    update_post_state(@post, @new_state) if @new_state
    @posts = requested_drafts
  end

  private

  def requested_drafts
    if params[:search]
      return Post.draft.search_titles(params[:search]).page params[:page]
    end
    Post.draft.page params[:page]
  end
end
