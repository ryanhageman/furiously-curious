# frozen_string_literal: true

class PostPresenter
  # creates links to change post state
  class StateLinks < BasePresenter
    presents :post

    def links(state)
      klass = "PostPresenter::#{state.capitalize}StateLinks".constantize
      klass.new(post, template).links
    end

    private

    def generate_link(link_text, new_state)
      h.link_to(link_text, path_to_change_state(new_state), link_options)
    end

    def path_to_change_state(new_state)
      "/blog_admin/#{h.controller_name}/#{post.id}?new_state=#{new_state}"
    end

    def link_options
      { method: :patch, remote: true }
    end
  end
end
