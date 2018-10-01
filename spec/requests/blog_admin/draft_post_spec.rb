# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BlogAdmin::Drafts requests' do
  let(:current_user) { create(:user, :admin) }

  before { login_as current_user }

  describe 'the BlogAdmin::Drafts index' do
    it 'returns only drafts' do
      subject = create(:post, title: 'First Draft')
      published_post = create(:post, :published, title: 'First Published')

      get blog_admin_drafts_path

      result = response.body

      expect(result).to include(subject.title)
      expect(result).not_to include(published_post.title)
    end
  end
end
