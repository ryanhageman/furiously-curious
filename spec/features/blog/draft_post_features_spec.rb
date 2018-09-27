# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Blog Draft Post Features', type: :feature do
  let(:current_user) { create(:user) }

  before do
    login_as current_user
    create(:profile, user_id: current_user.id)
  end

  describe 'user visits drafts index' do
    scenario 'they see a list of only the drafts' do
      subject = create(:post, title: 'First Draft')
      published_post = create(:post, :published, title: 'First Published')

      visit blog_admin_drafts_path

      expect(page).to have_content(subject.title)
      expect(page).not_to have_content(published_post.title)
    end
  end

  describe 'user searches drafts index' do
    scenario 'they see all the matching posts' do
      subject1 = create(:post, title: 'Lightsaber')
      subject2 = create(:post, title: 'Sabertooth Tiger')
      other_post = create(:post, title: 'Jedi')

      visit blog_admin_drafts_path
      
      fill_in 'search', with: 'saber'
      click_on 'Search'

      expect(page).to have_content(subject1.title)
      expect(page).to have_content(subject2.title)
      expect(page).not_to have_content(other_post.title)
    end
  end
end
