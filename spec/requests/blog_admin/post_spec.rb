# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BlogAdmin::Posts requests' do
  let(:current_user) { create(:user, :admin) }

  before do
    sign_in current_user
    create(:profile, user_id: current_user.id)
  end

  describe 'the BlogAdmin::Posts index' do
    it 'returns all the posts' do
      draft = create(:post, :draft)
      published = create(:post, :published)
      hidden = create(:post, :hidden)

      get blog_admin_posts_path

      result = response.body

      expect(result).to include(draft.title)
      expect(result).to include(published.title)
      expect(result).to include(hidden.title)
    end
  end

  describe 'the BlogAdmin::Posts edit view' do
    it 'has all the current tags in the form' do
      subject = create(:post, :with_tags)
      tag_names = subject.tags.map(&:name).join(', ')

      get edit_blog_admin_post_path(subject)

      result = response.body

      expect(result).to include(tag_names)
    end

    it 'has all the current categories in the form' do
      subject = create(:post, :with_categories)
      category_names = subject.categories.map(&:name).join(', ')

      get edit_blog_admin_post_path(subject)

      result = response.body

      expect(result).to include(category_names)
    end
  end
end
