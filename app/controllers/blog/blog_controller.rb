# frozen_string_literal: true

class Blog::BlogController < ApplicationController
  def update_post_state(post, new_state)
    post.publish! if new_state == 'published'
    post.hide! if new_state == 'hidden'
    post.save_as_draft! if new_state == 'draft'
  end
end
