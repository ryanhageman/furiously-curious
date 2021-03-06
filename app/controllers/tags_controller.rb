# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_search

  def index
    @tags = requested_tags
  end

  def show
    @tag = Tag.find(params[:id])
    @articles = Post.visible_with_specific_tag(@tag.id).page params[:page]
  end

  private

  def set_search
    @search = params[:search]
  end

  def requested_tags
    @search ? Tag.search_names(@search) : Tag.select(:name, :id)
  end
end
