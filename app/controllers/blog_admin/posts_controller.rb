# frozen_string_literal: true

module BlogAdmin
  class PostsController < BlogAdminController
    before_action :authenticate_user!
    before_action :set_and_authorize_post, only: %i[show edit update destroy]
    before_action :set_tags_and_categories, only: %i[new create edit update]
    before_action :set_profile
    after_action :verify_authorized, except: %i[index]

    def index
      @search = params[:search]
      @posts = requested_posts
    end

    def show; end

    def new
      @post = Post.new
      authorize @post
    end

    def create
      prepare_and_save(Post.new(post_params))
    end

    def edit
      @post.raw_tags = @post.form_friendly_tags
      @post.raw_categories = @post.form_friendly_categories
    end

    def update
      if new_state?
        update_state(@post)
      else
        prepare_and_update(@post)
      end
    end

    def destroy
      @post.destroy
      redirect_to blog_admin_posts_url
    end

    private

    def post_params
      params.require(:post).permit(:main_image, :title, :body, :raw_tags,
                                   :raw_categories, :delete_main_image,
                                   profiles_attributes: [post_images: []])
    end

    def author_is_current_user(post)
      post.author_id = current_user.id
    end

    def new_state?
      params[:new_state]
    end

    def update_state(post)
      update_post_state(post, params[:new_state])
      @posts = requested_posts
    end

    def prepare_and_save(post)
      authorize(post)
      author_is_current_user(post)
      post.post_tags_attributes = BlogPost::Tagger.new(params).add_post_tags
      post.post_categories_attributes = BlogPost::Categorizer.new(params).add_post_categories
      save_post(post)
    end

    def prepare_and_update(post)
      authorize(post)
      post.post_tags.destroy_all
      post.post_categories.destroy_all
      post.post_tags_attributes = BlogPost::Tagger.new(params).add_post_tags
      post.post_categories_attributes = BlogPost::Categorizer.new(params).add_post_categories
      update_post(post)
    end

    def save_post(post)
      if post.save
        redirect_to blog_admin_post_url(post), notice: 'Saved'
      else
        render :new, notice: 'There was a problem, try again.'
      end
    end

    def update_post(post)
      if post.update(post_params)
        redirect_to blog_admin_post_url(post), notice: 'Updated'
      else
        render :edit, notice: 'There was a problem'
      end
    end

    def set_and_authorize_post
      @post = Post.find(params[:id])
      authorize @post
    end

    def set_profile
      @profile = current_user.profile
    end

    def set_tags_and_categories
      @tags = Tag.pluck(:name)
      @categories = Category.pluck(:name)
    end

    def requested_posts
      if params[:search]
        return Post.search_titles(params[:search]).page params[:page]
      end
      Post.page params[:page]
    end
  end
end
