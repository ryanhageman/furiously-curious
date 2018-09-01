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
    author_username? ? post.author.profile.username : 'No Author'
  end

  def post_tags
    post.tags.empty? ? 'No Tags' : render_tags
  end

  def post_categories
    post.categories.empty? ? 'No Categories' : render_categories
  end

  def change_state_links
    case state
    when 'draft' then publish_post_link
    when 'published' then links_for_published_posts
    when 'hidden' then links_for_hidden_posts
    end
  end

  def title_link
    h.link_to post.title, h.blog_post_path(post)
  end

  def edit_post_link
    h.link_to 'Edit', h.edit_blog_post_path(post)
  end

  def delete_post_link
    h.link_to 'Delete', h.blog_post_path(post), method: :delete
  end

  def markdown_body
    h.markdown(post.body)
  end

  private

  def main_image?
    post.main_image.attached?
  end

  def author_username?
    post.author.profile.try(:username)
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

  def post_url
    "/blog/#{h.controller_name}/#{post.id}"
  end

  def publish_post_link
    h.link_to(
      'Publish',
      "#{post_url}?new_state=published",
      method: :patch,
      remote: true
    )
  end

  def hide_post_link
    h.link_to(
      'Hide',
      "#{post_url}?new_state=hidden",
      method: :patch,
      remote: true
    )
  end

  def save_as_draft_link
    h.link_to(
      'Save as Draft',
      "#{post_url}?new_state=draft",
      method: :patch,
      remote: true
    )
  end

  def links_for_published_posts
    [hide_post_link, save_as_draft_link].join(' ').html_safe
  end

  def links_for_hidden_posts
    [publish_post_link, save_as_draft_link].join(' ').html_safe
  end
end
