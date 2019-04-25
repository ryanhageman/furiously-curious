# frozen_string_literal: true

module BlogAdmin
  class CategoriesController < BlogAdminController
    before_action :set_category, only: %i[edit update destroy]

    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to blog_admin_categories_path, notice: 'Created'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @category.update(category_params)
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

    def set_category
      @category = Category.find(params[:id])
    end
  end
end
