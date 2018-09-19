# frozen_string_literal: true

class PostPresenter
  # creates links to change a draft's state
  class DraftStateLinks < StateLinks
    presents :post

    def links
      publish_post_link
    end

    private

    def publish_post_link
      generate_link('Publish', 'published')
    end
  end
end
