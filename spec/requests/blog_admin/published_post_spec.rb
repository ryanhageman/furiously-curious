# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BlogAdmin::PublishedPosts requests' do
  let(:current_user) { create(:user, :admin) }

  before { login_as current_user }

  describe 'the BlogAdmin::PublishedPosts index' do
    it 'returns only published posts' do
      subject = create(:post, :published, title: 'First Published Post')
      hidden_post = create(:post, :hidden, title: 'First Hidden Post')

      get blog_admin_published_posts_path

      result = response.body

      expect(result).to include(subject.title)
      expect(result).not_to include(hidden_post.title)
    end
  end
end
