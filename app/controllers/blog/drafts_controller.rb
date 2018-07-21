# frozen_string_literal: true

class Blog::DraftsController < Blog::BlogController
  def index
    @posts = Post.draft
  end
end
