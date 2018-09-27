# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPresenter::DraftStateLinks do
  let(:view) { ActionController::Base.new.view_context }

  describe 'change_state_links' do
    it 'returns a link to publish a post for drafts' do
      post = create(:post, :draft)
      subject = PostPresenter::DraftStateLinks.new(post, view)

      result = subject.links

      expect(result).to include('?new_state=published')
    end
  end
end
