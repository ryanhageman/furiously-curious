# frozen_string_literal: true

class Blog::PostsController < Blog::BlogController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_tags_and_categories, only: %i[new create edit update]
  before_action :set_profile
  after_action :verify_authorized, except: %i[index]

  def index
    @search = params[:search]
    @posts = requested_posts
  end

  def show
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    authorize @post
    @post.post_tags_attributes = @post.parse_raw_tags(params)
    @post.post_categories_attributes = @post.parse_raw_categories(params)

    if @post.save
      redirect_to blog_post_url(@post), notice: 'Saved'
    else
      render :new, notice: 'There was a problem, try again.'
    end
  end

  def edit
    authorize @post
    @post.raw_tags = convert_to_raw(@post.tags)
    @post.raw_categories = convert_to_raw(@post.categories)
  end

  def update
    authorize @post
    @new_state = params[:new_state]
    if @new_state
      update_post_state(@post, @new_state)
      @posts = requested_posts
    else
      @post.post_tags.destroy_all
      @post.post_categories.destroy_all

      @post.post_tags_attributes = @post.parse_raw_tags(params)
      @post.post_categories_attributes = @post.parse_raw_categories(params)

      if @post.update(post_params)
        redirect_to blog_post_url(@post), notice: 'Updated'
      else
        render :edit, notice: 'There was a problem'
      end
    end
  end

  def destroy
    authorize @post
    @post.destroy

    redirect_to blog_posts_url
  end

  private

  def post_params
    params.require(:post).permit(
      :main_image, :title,
      :body, :raw_tags,
      :raw_categories, :delete_main_image,
      profiles_attributes: [post_images: []]
    )
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_profile
    @profile = current_user.profile
    redirect_to new_accounts_profile_url if @profile.nil?
  end

  def set_tags_and_categories
    @tags = Tag.pluck(:name)
    @categories = Category.pluck(:name)
  end

  def convert_to_raw(data)
    data.map(&:name).join(', ')
  end

  def requested_posts
    if params[:search]
      return Post.search_titles(params[:search]).page params[:page]
    end
    Post.page params[:page]
  end
end
