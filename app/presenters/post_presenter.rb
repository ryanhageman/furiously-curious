# frozen_string_literal: true

class PostPresenter < BasePresenter
  presents :post
  delegate :title, to: :post

  def state
    post.aasm_state
  end

  def main_image
    h.image_tag post.main_image if main_image?
  end

  def author_username
    post.author.profile.username
  end

  def post_tags
    post.tags.empty? ? 'No Tags' : render_tags
  end

  def post_categories
    post.categories.empty? ? 'No Categories' : render_categories
  end

  def change_state_links
    PostPresenter::StateLinks
      .new(post, template)
      .links(state)
  end

  def title_link
    h.link_to post.title, h.blog_admin_post_path(post)
  end

  def edit_post_link
    h.link_to 'Edit', h.edit_blog_admin_post_path(post)
  end

  def delete_post_link
    h.link_to 'Delete', h.blog_admin_post_path(post), method: :delete
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
        h.content_tag :li, category.name
      end.join.html_safe
    end
  end
end
