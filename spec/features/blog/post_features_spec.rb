# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Blog Post Features', type: :feature do
  let(:current_user) { create(:user) }

  before do
    login_as current_user
    create(:profile, user_id: current_user.id)
  end

  describe 'user visits the post index' do
    before do
      create(:post, title: 'First Post', body: 'a post for the world')
      create(:post, title: 'Second Post')
    end

    scenario 'they see a list of all the posts' do
      visit blog_posts_path

      expect(page).to have_content('First Post')
      expect(page).to have_content('Second Post')
    end

    scenario 'they can look at a specific post' do
      visit blog_posts_path

      click_on 'First Post'

      expect(page).to have_content('a post for the world')
    end

    scenario 'they create a new post' do
      visit blog_posts_path

      click_on 'New Post'

      fill_in 'Title', with: 'A New Post'
      fill_in 'post_body', with: 'All the news thats fit to print'
      click_on 'Create Post'

      expect(page).to have_content('A New Post')
      expect(page).to have_content('All the news thats fit to print')
    end

    scenario 'they edit a post' do
      visit blog_posts_path

      click_on 'Edit', match: :first

      fill_in 'Title', with: 'Updated Title'
      click_on 'Update Post'

      expect(page).to have_content('Updated Title')
    end

    scenario 'they destroy a post' do
      visit blog_posts_path

      expect(page).to have_content('First Post')

      click_on 'Delete', match: :first

      expect(page).not_to have_content('First Post')
      expect(page).to have_content('Second Post')
    end
  end

  describe 'user searches posts index' do
    before do
      create(:post, title: 'Gambit')
      create(:post, title: 'Sabertooth Bit Another Reeses Egg')
      create(:post, title: 'Wolverine')
    end

    scenario 'they see all the matching posts' do
      visit blog_posts_path

      fill_in 'search', with: 'bit'

      click_on 'Search'

      expect(page).to have_content('Gambit')
      expect(page).to have_content('Sabertooth Bit Another Reeses Egg')
      expect(page).not_to have_content('Wolverine')
    end
  end
end
