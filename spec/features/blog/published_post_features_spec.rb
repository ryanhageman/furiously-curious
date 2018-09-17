# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Blog Published Post Features', type: :feature do
  let(:current_user) { create(:user) }

  before do
    login_as current_user
    create(:profile, user_id: current_user.id)
  end

  describe 'user visits published posts index' do
    before do
      create(:post, :published, title: 'First Published Post')
      create(:post, :published, title: 'First Hidden Post').hide!
    end

    scenario 'they see a list of all the published posts' do
      visit blog_admin_published_posts_path

      expect(page).to have_content('First Published Post')
    end

    scenario 'they do NOT see hidden posts' do
      visit blog_admin_published_posts_path

      expect(page).not_to have_content('First Hidden Post')
    end
  end

  describe 'user searches published posts index' do
    before do
      create(:post, :published, title: 'Expecto Patronum')
      create(:post, :published, title: 'I expect a nice wig for my head')
      create(:post, :published, title: 'Headwig')
    end

    scenario 'they see all the matching published posts' do
      visit blog_admin_published_posts_path

      fill_in 'search', with: 'expect'

      click_on 'Search'

      expect(page).to have_content('Expecto Patronum')
      expect(page).to have_content('I expect a nice wig for my head')
      expect(page).not_to have_content('Headwig')
    end
  end
end
