# frozen_string_literal: true

module BlogAdmin
  class PostsController < BlogAdminController
    before_action :authenticate_user!
    after_action :verify_authorized, except: %i[index]

    def index
      @profile = current_user.profile
      @search = params[:search]

      if params[:search]
        @posts = Post.search_titles(params[:search]).page params[:page]
      else
        @posts = Post.page params[:page]
      end
    end

    def show
      @profile = current_user.profile
      @post = Post.find(params[:id])
      authorize @post
    end

    def new
      @tags = Tag.pluck(:name)
      @categories = Category.pluck(:name)
      @profile = current_user.profile
      @post = Post.new
      authorize @post
    end

    def create
      @tags = Tag.pluck(:name)
      @categories = Category.pluck(:name)
      @profile = current_user.profile
      @post = Post.new(post_params)
      authorize(@post)
      @post.author_id = current_user.id
      @post.post_tags_attributes = BlogPost::Tagger.new(params).add_post_tags
      @post.post_categories_attributes = BlogPost::Categorizer.new(params).add_post_categories

      if @post.save
        redirect_to blog_admin_post_url(@post), notice: 'Saved'
      else
        render :new, notice: 'There was a problem, try again.'
      end
    end

    def edit
      @tags = Tag.pluck(:name)
      @categories = Category.pluck(:name)
      @profile = current_user.profile
      @post = Post.find(params[:id])
      authorize @post
      @post.raw_tags = @post.form_friendly_tags
      @post.raw_categories = @post.form_friendly_categories
    end

    def update
      @tags = Tag.pluck(:name)
      @categories = Category.pluck(:name)
      @profile = current_user.profile
      @post = Post.find(params[:id])
      authorize @post
      if params[:new_state]
        update_post_state(@post, params[:new_state])
        @posts = requested_posts
      else
        authorize(@post)
        @post.post_tags.destroy_all
        @post.post_categories.destroy_all
        @post.post_tags_attributes = BlogPost::Tagger.new(params).add_post_tags
        @post.post_categories_attributes = BlogPost::Categorizer.new(params).add_post_categories

        if @post.update(post_params)
          redirect_to blog_admin_post_url(@post), notice: 'Updated'
        else
          render :edit, notice: 'There was a problem'
        end
      end
    end

    def destroy
      @profile = current_user.profile
      @post = Post.find(params[:id])
      authorize @post
      @post.destroy
      redirect_to blog_admin_posts_url
    end

    private

    def post_params
      params.require(:post).permit(:main_image, :title, :body, :raw_tags,
                                   :raw_categories, :delete_main_image,
                                   profiles_attributes: [post_images: []])
    end
  end
end
