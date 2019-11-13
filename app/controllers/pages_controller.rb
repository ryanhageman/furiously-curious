# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_search

  def recent
    @articles = requested_articles
    @tags = Tag.select(:name, :id)
    @categories = Category.select(:name, :id)
  end

  def about; end

  private

  def set_search
    @search = params[:search]
  end

  def requested_articles
    return view_scope.with_specific_tag(tag_filter) if tag_filter
    return view_scope.with_specific_category(category_filter) if category_filter
    return view_scope.search_titles_and_body(@search) if @search

    Post.latest
  end

  def view_scope
    Post.published
  end

  def tag_filter
    params[:tag_id]
  end

  def category_filter
    params[:category_id]
  end
end
