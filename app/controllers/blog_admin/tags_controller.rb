# frozen_string_literal: true

module BlogAdmin
  class TagsController < BlogAdminController
    before_action :authenticate_user!
    before_action :set_tag, only: %i[edit update destroy]

    def index
      @tags = Tag.all
    end

    def new
      @tag = Tag.new
    end

    def create
      @tag = Tag.new(tag_params)

      if @tag.save
        redirect_to blog_admin_tags_url, notice: 'Your tag was created.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @tag.update(tag_params)
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

    def set_tag
      @tag = Tag.find(params[:id])
    end
  end
end
