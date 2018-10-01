# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Blog Published Post Features', type: :feature do
  let(:current_user) { create(:user) }

  before { login_as current_user }

  describe 'user searches published posts index' do
    scenario 'they see all the matching published posts' do
      subject1 = create(:post, :published, title: 'Oompa loompa doompity doo')
      subject2 = create(:post, :published, title: 'Loompa land')
      other_post = create(:post, :published, title: 'A Golden TICKET!!')

      visit blog_admin_published_posts_path
      fill_in 'search', with: 'loompa'
      click_on 'Search'

      result = page

      expect(result).to have_content(subject1.title)
      expect(result).to have_content(subject2.title)
      expect(result).not_to have_content(other_post.title)
    end
  end
end
