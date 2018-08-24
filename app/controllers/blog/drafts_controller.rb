# frozen_string_literal: true

class Blog::DraftsController < Blog::BlogController
  def index
    @search = params[:search]
    @posts = requested_posts
  end
end
