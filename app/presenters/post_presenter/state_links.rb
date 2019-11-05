# frozen_string_literal: true

class PostPresenter
  # creates links to change post state
  class StateLinks < BasePresenter
    presents :post

    def initialize(object, template, class_name = '')
      @object = object
      @template = template
      @class_name = class_name
    end

    def links(state, class_name = '')
      klass = "PostPresenter::#{state.capitalize}StateLinks".constantize
      klass.new(post, template, class_name).links
    end

    private

    def generate_link(link_text, new_state)
      h.link_to(link_text, path_to_change_state(new_state), link_options)
    end

    def path_to_change_state(new_state)
      "/blog_admin/#{h.controller_name}/#{post.id}?new_state=#{new_state}"
    end

    def link_options
      { method: :patch, remote: true, class: @class_name }
    end
  end
end
