# frozen_string_literal: true

class PostPresenter
  # creates links to change a published post's state
  class PublishedStateLinks < StateLinks
    presents :post

    def links
      [hide_post_link, save_as_draft_link].join(' ').html_safe
    end

    private

    def hide_post_link
      generate_link('Hide', 'hidden')
    end

    def save_as_draft_link
      generate_link('Save as Draft', 'draft')
    end
  end
end
