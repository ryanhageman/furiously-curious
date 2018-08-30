# frozen_string_literal: true

class PostPresenter < BasePresenter
  presents :post
  delegate :title, to: :post

  def change_state_links
    case post.aasm_state
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

  private

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
