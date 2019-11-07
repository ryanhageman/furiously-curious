# frozen_string_literal: true

# Presenter for Posts
class PostPresenter < BasePresenter
  presents :post
  attr_reader :all_tags, :all_categories
  delegate :title, to: :post

  def initialize(object, template)
    super
    @all_tags = Tag.pluck(:name)
    @all_categories = Category.pluck(:name)
  end

  def state
    post.aasm_state
  end

  def main_image(class_name = '')
    return h.image_tag post.main_image, class: class_name if main_image?

    h.image_tag 'no_image_available.svg', class: class_name
  end

  def author_username
    post.author.profile.username
  end

  def created_date
    post.created_at.strftime('%B %d, %Y')
  end

  def last_update
    post.updated_at.strftime('%B %d, %Y')
  end

  def post_tags
    post.tags.empty? ? 'No Tags' : render_tags
  end

  def post_categories
    post.categories.empty? ? 'No Categories' : render_categories
  end

  def change_state_links(class_name = '')
    PostPresenter::StateLinks
      .new(post, template, class_name)
      .links(state, class_name)
  end

  def title_link(class_name = '')
    h.link_to post.title, h.blog_admin_post_path(post), class: class_name
  end

  def edit_post_link(class_name = '')
    h.link_to 'Edit', h.edit_blog_admin_post_path(post), class: class_name
  end

  def delete_post_link(class_name = '')
    h.link_to 'Delete', h.blog_admin_post_path(post), method: :delete, class: class_name
  end

  def markdown_body
    h.markdown(post.body)
  end

  private

  def main_image?
    post.main_image.attached?
  end

  def render_tags
    h.content_tag :ul do
      post.tags.collect { |tag| h.content_tag :li, tag.name }.join.html_safe
    end
  end

  def render_categories
    h.content_tag :ul do
      post.categories.collect do |category|
        h.content_tag :li, category.name.titleize
      end.join.html_safe
    end
  end
end
