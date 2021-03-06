# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_search

  def index
    @categories = requested_categories
  end

  def show
    @category = Category.find(params[:id])
    @articles = Post.visible_with_specific_category(@category.id)
                    .page params[:page]
  end

  private

  def set_search
    @search = params[:search]
  end

  def requested_categories
    @search ? Category.search_names(@search) : Category.select(:name, :id)
  end
end
