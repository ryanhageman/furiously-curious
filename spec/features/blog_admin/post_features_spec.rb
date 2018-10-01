# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Blog Post Features', type: :feature do
  let(:current_user) { create(:user, :author) }

  before do
    login_as current_user
    create(:profile, user_id: current_user.id)
  end

  describe 'user visits the post index' do
    let(:post1) do
      create(:post,
             title: 'First Post',
             body: 'a post for the world',
             author_id: current_user.id)
    end

    let(:post2) do
      create(:post, title: 'Second Post', author_id: current_user.id)
    end

    scenario 'they can look at a specific post' do
      subject = post1

      visit blog_admin_posts_path
      click_on subject.title

      result = page

      expect(result).to have_content(subject.body)
    end

    scenario 'they create a new post' do
      visit blog_admin_posts_path
      click_on 'New Post'

      fill_in 'Title', with: 'A New Post'
      fill_in 'post_body', with: 'All the news thats fit to print'
      click_on 'Create Post'

      result = page

      expect(result).to have_content('A New Post')
      expect(result).to have_content('All the news thats fit to print')
    end

    scenario 'they edit a post' do
      post1

      visit blog_admin_posts_path
      click_on 'Edit'
      fill_in 'Title', with: 'Updated Title'
      click_on 'Update Post'

      result = page

      expect(result).to have_content('Updated Title')
    end

    scenario 'they destroy a post' do
      subject = post1
      other_post = post2

      visit blog_admin_posts_path

      expect(page).to have_content(subject.title)

      click_on 'Delete', match: :first

      result = page

      expect(result).not_to have_content(subject.title)
      expect(result).to have_content(other_post.title)
    end
  end

  describe 'user searches posts index' do
    scenario 'they see all the matching posts' do
      subject1 = create(:post, title: 'Gambit')
      subject2 = create(:post, title: 'Sabertooth Bit Another Reeses Egg')
      other_post = create(:post, title: 'Wolverine')

      visit blog_admin_posts_path
      fill_in 'search', with: 'bit'
      click_on 'Search'

      result = page

      expect(result).to have_content(subject1.title)
      expect(result).to have_content(subject2.title)
      expect(result).not_to have_content(other_post.title)
    end
  end
end
