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
    state_links = {
      draft: links_for_drafts,
      published: links_for_published_posts,
      hidden: links_for_hidden_posts
    }

    state_links[post.aasm_state.to_sym]
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

  def path_to_change_state(new_state)
    "/blog/#{h.controller_name}/#{post.id}?new_state=#{new_state}"
  end

  def link_options
    { method: :patch, remote: true }
  end

  def publish_post_link
    h.link_to('Publish', path_to_change_state('published'), link_options)
  end

  def hide_post_link
    h.link_to('Hide', path_to_change_state('hidden'), link_options)
  end

  def save_as_draft_link
    h.link_to('Save as Draft', path_to_change_state('draft'), link_options)
  end

  def links_for_drafts
    publish_post_link
  end

  def links_for_published_posts
    [hide_post_link, save_as_draft_link].join(' ').html_safe
  end

  def links_for_hidden_posts
    [publish_post_link, save_as_draft_link].join(' ').html_safe
  end
end
