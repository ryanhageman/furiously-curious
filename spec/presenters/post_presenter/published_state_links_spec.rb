# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPresenter::PublishedStateLinks do
  let(:view) { ActionController::Base.new.view_context }

  describe 'change_state_links' do
    it 'returns links to save as draft and hide for published posts' do
      post = create(:post, :published)
      subject = PostPresenter::PublishedStateLinks.new(post, view)

      result = subject.links

      expect(result).to include('?new_state=draft')
      expect(result).to include('?new_state=hidden')
    end
  end
end
