# frozen_string_literal: true

module BlogAdmin
  class TagsController < BlogAdminController
    before_action :set_authorized_tag, only: %i[edit show update destroy]
    after_action :verify_authorized, except: %i[index]

    def index
      @tags = requested_tags
    end

    def new
      @tag = new_authorized_tag
    end

    def show
      @posts = requested_posts
    end

    def create
      @tag = new_authorized_tag(tag_params)
      save_tag
    end

    def edit; end

    def update
      if params[:post_id]
        set_authorized_post
        change_post_state
      elsif @tag.update(tag_params)
        redirect_to blog_admin_tags_url, notice: 'Updated'
      else
        render :edit, notice: 'There was a problem'
      end
    end

    def destroy
      @tag.destroy
      redirect_to blog_admin_tags_url
    end

    private

    def tag_params
      params.require(:tag).permit(:name)
    end

    def new_authorized_tag(params = {})
      tag = Tag.new(params)
      authorize tag
      tag
    end

    def set_authorized_tag
      @tag = Tag.find(params[:id])
      authorize @tag
    end

    def set_authorized_post
      @post = Post.find(params[:post_id])
      authorize @post
    end

    def save_tag
      if @tag.save
        redirect_to blog_admin_tags_url, notice: 'Your tag was created.'
      else
        render :new
      end
    end

    def requested_tags
      @search ? Tag.search_names(@search) : Tag.select(:name, :id)
    end
  end
end
