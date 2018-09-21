# frozen_string_literal: true

# Organize posts with things like categories and tags.
class PostOrganizer
  attr_reader :params
  attr_accessor :post

  def initialize(post, params = {})
    @post = post
    @params = params
  end

  def prepare_post
    update_post_taxonomy
    post
  end

  def prepare_update_post
    clear_post_taxonomy
    update_post_taxonomy
    post
  end

  def convert_for_form
    post.raw_tags = convert_to_raw(post.tags)
    post.raw_categories = convert_to_raw(post.categories)
  end

  private

  def convert_to_raw(data)
    data.map(&:name).join(', ')
  end

  def update_post_taxonomy
    add_tags
    add_categories
  end

  def clear_post_taxonomy
    clear_old_tags
    clear_old_categories
  end

  def add_tags
    post.post_tags_attributes = post.parse_raw_tags(params)
  end

  def add_categories
    post.post_categories_attributes = post.parse_raw_categories(params)
  end

  def clear_old_tags
    post.post_tags.destroy_all
  end

  def clear_old_categories
    post.post_categories.destroy_all
  end
end
