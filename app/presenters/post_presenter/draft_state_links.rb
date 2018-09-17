# frozen_string_literal: true

class PostPresenter
  # creates links to change a draft's state
  class DraftStateLinks < StateLinks
    presents :post

    def links
      publish_post_link
    end

    private

    def generate_link(link_text, new_state)
      h.link_to(link_text, path_to_change_state(new_state), link_options)
    end

    def publish_post_link
      generate_link('Publish', 'published')
    end

    def path_to_change_state(new_state)
      "/blog/#{h.controller_name}/#{post.id}?new_state=#{new_state}"
    end

    def link_options
      { method: :patch, remote: true }
    end
  end
end
