# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BlogAdmin::HiddenPosts requests' do
  let(:current_user) { create(:user, :admin) }

  before { login_as current_user }

  describe 'the BlogAdmin::HiddenPosts index' do
    it 'returns only hidden posts' do
      subject = create(:post, :hidden, title: 'First Hidden Post')
      other_post = create(:post, :published, title: 'First Published Post')

      get blog_admin_hidden_posts_path

      result = response.body

      expect(result).to include(subject.title)
      expect(result).not_to include(other_post.title)
    end
  end
end
