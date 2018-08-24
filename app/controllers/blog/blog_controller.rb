# frozen_string_literal: true

class Blog::BlogController < ApplicationController
  private

  def requested_posts
    if params[:search]
      return Post.draft.where('title ILIKE ?', "%#{params[:search]}%").page params[:page]
    end
    Post.draft.page params[:page]
  end
end
