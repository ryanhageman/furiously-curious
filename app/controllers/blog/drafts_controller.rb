# frozen_string_literal: true

class Blog::DraftsController < Blog::BlogController
  def index
    @search = params[:search]
    @posts = requested_posts
  end

  private

  def requested_posts
    if params[:search]
      return Post.draft.where('title ILIKE ?', "%#{params[:search]}%").page params[:page]
    end
    Post.draft.page params[:page]
  end
end
