# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'BlogAdmin::HiddenPosts Features', type: :feature do
  let(:current_user) { create(:user) }

  before { login_as current_user }

  describe 'user searches BlogAdmin::HiddenPosts index' do
    scenario 'they see all the matching hidden posts' do
      subject1 = create(:post, :hidden, title: 'Expecto Patronum')
      subject2 = create(:post, :hidden, title: 'Expect a nice wig on your head')
      other_post = create(:post, :hidden, title: 'Headwig')

      visit blog_admin_hidden_posts_path
      fill_in 'search', with: 'expect'
      click_on 'Search'

      result = page

      expect(result).to have_content(subject1.title)
      expect(result).to have_content(subject2.title)
      expect(result).not_to have_content(other_post.title)
    end
  end
end
