# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPresenter::PublishedStateLinks do
  let(:view) { ActionController::Base.new.view_context }

  describe 'change_state_links' do
    it 'returns links to save as draft and hide for published posts' do
      post = create(:post, :published)
      presenter = PostPresenter::PublishedStateLinks.new(post, view)

      expect(presenter.links).to include('?new_state=draft')
      expect(presenter.links).to include('?new_state=hidden')
    end
  end
end
