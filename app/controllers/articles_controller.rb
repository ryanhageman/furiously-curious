#frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Post.latest
  end
end
