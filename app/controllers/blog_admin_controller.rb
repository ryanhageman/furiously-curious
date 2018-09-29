# frozen_string_literal: true

class BlogAdminController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  before_action :set_search

  private

  def update_post_state
    @post.publish! if new_state == 'published'
    @post.hide! if new_state == 'hidden'
    @post.save_as_draft! if new_state == 'draft'
  end

  def set_search
    @search = params[:search]
  end

  def set_profile
    @profile = current_user.profile
  end

  def requested_posts
    if @search
      return @posts = view_scope.search_titles(@search).page(current_page)
    end
    @posts = view_scope.page current_page
  end

  def set_authorized_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def change_post_state
    update_post_state if new_state
    @posts = requested_posts
  end

  def view_scope
    Post
  end

  def current_page
    params[:page]
  end

  def new_state
    params[:new_state]
  end
end
