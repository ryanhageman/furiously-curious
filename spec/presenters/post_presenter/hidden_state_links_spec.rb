# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPresenter::HiddenStateLinks do
  let(:view) { ActionController::Base.new.view_context }

  describe 'change_state_links' do
    it 'returns links to save as draft and publish for hidden posts' do
      post = create(:post, :hidden)
      presenter = PostPresenter::HiddenStateLinks.new(post, view)

      expect(presenter.links).to include('?new_state=draft')
      expect(presenter.links).to include('?new_state=published')
    end
  end
end
