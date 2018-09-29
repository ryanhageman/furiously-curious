# frozen_string_literal: true

module BlogAdmin
  class DraftsController < BlogAdminController
    after_action :verify_authorized, except: %i[index]

    def index
      requested_posts
    end

    def update
      set_authorized_post
      change_post_state
    end

    private

    def view_scope
      Post.draft
    end
  end
end
