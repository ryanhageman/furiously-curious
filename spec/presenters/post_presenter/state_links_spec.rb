# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPresenter::StateLinks do
  let(:view) { ActionController::Base.new.view_context }

  describe 'change_state_links' do
    it 'returns a link to publish a post for drafts' do
      post = create(:post, :draft)
      state = post.aasm_state
      subject = PostPresenter::StateLinks.new(post, view)

      result = subject.links(state)

      expect(result).to include('?new_state=published')
    end

    it 'returns links to save as draft and hide for published posts' do
      post = create(:post, :published)
      state = post.aasm_state
      presenter = PostPresenter::StateLinks.new(post, view)
      response = presenter.links(state)

      expect(response).to include('?new_state=draft')
      expect(response).to include('?new_state=hidden')
    end

    it 'returns links to save as draft and publish for hidden posts' do
      post = create(:post, :hidden)
      state = post.aasm_state
      presenter = PostPresenter::StateLinks.new(post, view)
      response = presenter.links(state)

      expect(response).to include('?new_state=draft')
      expect(response).to include('?new_state=published')
    end
  end
end
