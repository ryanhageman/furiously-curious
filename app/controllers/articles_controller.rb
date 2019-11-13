# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_search

  def index
    @articles = requested_articles
    @tags = Tag.select(:name, :id)
    @categories = Category.select(:name, :id)
  end

  def show
    @article = Post.find(params[:id])
  end

  private

  def set_search
    @search = params[:search]
  end

  def requested_articles
    return paginated_posts_with_specific_tag if tag_filter
    return paginated_posts_with_specific_category if category_filter
    return paginated_search_results if @search

    view_scope.page params[:page]
  end

  def view_scope
    Post.published
  end

  def paginated_posts_with_specific_tag
    view_scope.with_specific_tag(tag_filter).page params[:page]
  end

  def paginated_posts_with_specific_category
    view_scope.with_specific_category(category_filter).page params[:page]
  end

  def paginated_search_results
    view_scope.search_titles_and_body(@search).page params[:page]
  end

  def tag_filter
    params[:tag_id]
  end

  def category_filter
    params[:category_id]
  end
end
