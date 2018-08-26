# frozen_string_literal: true

class Blog::DraftsController < Blog::BlogController
  before_action :authenticate_user!
  
  def index
    @search = params[:search]
    @posts = requested_drafts
  end

  private

  def requested_drafts
    if params[:search]
      return Post.draft.where('title ILIKE ?', "%#{params[:search]}%").page params[:page]
    end
    Post.draft.page params[:page]
  end
end
