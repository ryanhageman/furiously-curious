# frozen_string_literal: true

module BlogAdmin
  class PostsController < BlogAdminController
    before_action :set_authorized_post, only: %i[show edit update destroy]
    after_action :verify_authorized, except: %i[index]

    def index
      @posts = requested_posts
    end

    def show; end

    def new
      @post = new_authorized_post
    end

    def create
      @post = prepare_post
      save_post
    end

    def edit; end

    def update
      if new_state
        change_post_state
      else
        update_post
      end
    end

    def destroy
      @post.destroy
      redirect_to blog_admin_posts_url
    end

    private

    def post_params
      params.require(:post).permit( :main_image, :title, :summary, :body,
                                    :raw_tags, :raw_categories, :delete_main_image,
                                    profiles_attributes: [post_images: []])
    end

    def new_authorized_post(params = {})
      post = Post.new(params)
      authorize post
      post
    end

    def prepare_post
      post = new_authorized_post(post_params)
      post.author_id = current_user.id
      post.add_taxonomy(params)
      post
    end

    def save_post
      if @post.save
        redirect_to blog_admin_post_url(@post), notice: 'Saved'
      else
        render :new, notice: 'There was a problem.'
      end
    end

    def update_post
      @post.update_taxonomy(params)
      redirect_on_update
    end

    def redirect_on_update
      if @post.update(post_params)
        redirect_to blog_admin_post_url(@post), notice: 'Updated'
      else
        render :edit, notice: 'There was a problem.'
      end
    end
  end
end
