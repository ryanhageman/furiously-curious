# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_search

  def index
    requested_articles
  end

  private

  def set_search
    @search = params[:search]
  end

  def requested_articles
    if @search
      return @articles = Post.published.search_titles_and_body(@search)
    end
    @articles = Post.latest
  end
end
