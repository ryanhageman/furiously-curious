# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_tags_and_categories, only: %i[new create edit update]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.post_tags_attributes = @post.parse_raw_tags(params)
    @post.post_categories_attributes = @post.parse_raw_categories(params)

    if @post.save
      redirect_to @post, notice: 'Saved'
    else
      render :new, notice: 'There was a problem, try again.'
    end
  end

  def edit
    @post.raw_tags = convert_to_raw(@post.tags)
    @post.raw_categories = convert_to_raw(@post.categories)
  end

  def update
    @post.post_tags.destroy_all
    @post.post_categories.destroy_all

    @post.post_tags_attributes = @post.parse_raw_tags(params)
    @post.post_categories_attributes = @post.parse_raw_categories(params)

    if @post.update(post_params)
      redirect_to @post, notice: 'Updated'
    else
      render :edit, notice: 'There was a problem'
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(
      :main_image, :title,
      :body, :raw_tags,
      :raw_categories, :delete_main_image
    )
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_tags_and_categories
    @tags = Tag.pluck(:name)
    @categories = Category.pluck(:name)
  end

  def convert_to_raw(data)
    data.map(&:name).join(', ')
  end
end
