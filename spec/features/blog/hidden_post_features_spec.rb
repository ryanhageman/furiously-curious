# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Blog Hidden Post Features', type: :feature do
  let(:current_user) { create(:user) }

  before do
    login_as current_user
    create(:profile, user_id: current_user.id)
  end

  describe 'user visits hidden posts index' do
    scenario 'they see a list of only the hidden posts' do
      subject = create(:post, :hidden, title: 'First Hidden Post')
      other_post = create(:post, :published, title: 'First Published Post')

      visit blog_admin_hidden_posts_path

      expect(page).to have_content(subject.title)
      expect(page).not_to have_content(other_post.title)
    end
  end

  describe 'user searches hidden posts index' do
    scenario 'they see all the matching hidden posts' do
      subject1 = create(:post, :hidden, title: 'Expecto Patronum')
      subject2 = create(:post, :hidden, title: 'Expect a nice wig on your head')
      other_post = create(:post, :hidden, title: 'Headwig')

      visit blog_admin_hidden_posts_path

      fill_in 'search', with: 'expect'
      click_on 'Search'

      expect(page).to have_content(subject1.title)
      expect(page).to have_content(subject2.title)
      expect(page).not_to have_content(other_post.title)
    end
  end
end
