# frozen_string_literal: true

module BlogAdmin
  class TagsController < BlogAdminController
    before_action :set_authorized_tag, only: %i[edit update destroy]

    def index
      @tags = requested_tag
    end

    def new
      @tag = new_authorized_tag
    end

    def create
      @tag = new_authorized_tag(tag_params)
      save_tag
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

    def new_authorized_tag(params = {})
      tag = Tag.new(params)
      authorize tag
      tag
    end

    def set_authorized_tag
      @tag = Tag.find(params[:id])
      authorize @tag
    end

    def save_tag
      if @tag.save
        redirect_to blog_admin_tags_url, notice: 'Your tag was created.'
      else
        render :new
      end
    end

    def requested_tag
      @search ? Tag.search_names(@search) : Tag.select(:name, :id)
    end
  end
end
