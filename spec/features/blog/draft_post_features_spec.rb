# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Blog Draft Post Features', type: :feature do
  let(:current_user) { create(:user) }

  before do
    login_as current_user
    create(:profile, user_id: current_user.id)
  end

  describe 'user visits drafts index' do
    before do
      create(:post, title: 'First Draft')
      create(:post, :published, title: 'First Published')
    end

    scenario 'they see a list of all the drafts' do
      visit blog_drafts_path

      expect(page).to have_content('First Draft')
    end

    scenario 'they do NOT see published posts' do
      visit blog_drafts_path

      expect(page).not_to have_content('First Published')
    end
  end

  describe 'user searches drafts index' do
    before do
      create(:post, title: 'Lightsaber')
      create(:post, title: 'Sabertooth Tiger')
      create(:post, title: 'Jedi')
    end

    scenario 'they see all the matching posts' do
      visit blog_drafts_path

      fill_in 'search', with: 'saber'

      click_on 'Search'

      expect(page).to have_content('Lightsaber')
      expect(page).to have_content('Sabertooth Tiger')
      expect(page).not_to have_content('Jedi')
    end
  end
end
