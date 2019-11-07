# frozen_string_literal: true

module BlogAdmin
  class CategoriesController < BlogAdminController
    before_action :set_authorized_category, only: %i[edit show update destroy]
    after_action :verify_authorized, except: %i[index]

    def index
      @categories = requested_categories
    end

    def new
      @category = new_authorized_category
    end

    def show
      @posts = requested_posts
    end

    def create
      @category = new_authorized_category(category_params)
      save_category
    end

    def edit; end

    def update
      if params[:post_id]
        set_authorized_post
        change_post_state
      elsif @category.update(category_params)
        redirect_to blog_admin_categories_path, notice: 'Updated'
      else
        render :edit
      end
    end

    def destroy
      @category.destroy
      redirect_to blog_admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end

    def new_authorized_category(params = {})
      category = Category.new(params)
      authorize category
      category
    end

    def set_authorized_category
      @category = Category.find(params[:id])
      authorize @category
    end

    def set_authorized_post
      @post = Post.find(params[:post_id])
      authorize @post
    end

    def save_category
      if @category.save
        redirect_to blog_admin_categories_path, notice: 'Created'
      else
        render :new
      end
    end

    def requested_categories
      @search ? Category.search_names(@search) : Category.select(:name, :id)
    end

    def view_scope
      category = Category.find(params[:id])
      Post.with_specific_category(category.id)
    end
  end
end
