# frozen_string_literal: true

class PostPresenter
  # creates links to change a hidden post's state
  class HiddenStateLinks < StateLinks
    presents :post

    def links
      [publish_post_link, save_as_draft_link].join(' ').html_safe
    end

    private

    def publish_post_link
      generate_link('Publish', 'published')
    end

    def save_as_draft_link
      generate_link('Save as Draft', 'draft')
    end
  end
end
