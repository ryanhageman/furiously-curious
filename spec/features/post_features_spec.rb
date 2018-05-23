# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Post Features', type: :feature do
  let(:current_user) { create(:user) }

  before { login_as current_user }

  describe 'user visits the post index' do
    before do
      create(:post, title: 'First Post', body: 'a post for the world')
      create(:post, title: 'Second Post')
    end

    scenario 'they see a list of all the posts' do
      visit posts_path

      expect(page).to have_content('First Post')
      expect(page).to have_content('Second Post')
    end

    scenario 'they can look at a specific post' do
      visit posts_path

      click_on 'First Post'

      expect(page).to have_content('a post for the world')
    end

    scenario 'they create a new post' do
      visit posts_path

      click_on 'New Post'

      fill_in 'Title', with: 'A New Post'
      fill_in 'Body', with: 'All the news thats fit to print'
      click_on 'Create Post'

      expect(page).to have_content('A New Post')
      expect(page).to have_content('All the news thats fit to print')
    end

    scenario 'they edit a post' do
      visit posts_path

      click_on 'Edit', match: :first

      fill_in 'Title', with: 'Updated Title'
      click_on 'Update Post'

      expect(page).to have_content('Updated Title')
    end

    scenario 'they destroy a post' do
      visit posts_path

      expect(page).to have_content('First Post')

      click_on 'Delete', match: :first

      expect(page).not_to have_content('First Post')
      expect(page).to have_content('Second Post')
    end
  end
end
