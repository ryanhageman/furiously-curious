# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Category Features', type: :feature do
  describe 'user searches categories index' do
    scenario 'they see all the matching categories' do
      subject1 = create(:category, name: 'oingo')
      subject2 = create(:category, name: 'boingo')
      other_category = create(:category, name: 'weird science')

      visit categories_path
      fill_in 'search',	with: 'oingo'
      click_on 'Search'

      result = page

      expect(result).to have_content(/#{subject1.name}/i)
      expect(result).to have_content(/#{subject2.name}/i)
      expect(result).not_to have_content(/#{other_category.name}/i)
    end
  end

  let(:post) { create(:post, :published, :with_specific_category) }

  describe 'user clicks a category name' do
    scenario 'they see a list of all the articles in a specific category' do
      subject_category = post.categories.first
      subject_post = post

      visit categories_path
      click_on subject_category.name.titleize

      result = page

      expect(result).to have_content(/#{subject_category.name}/i)
      expect(result).to have_content(subject_post.title)
    end

    scenario 'they can click an article in that category and see it' do
      post_category = post.categories.first.name.titleize
      subject_post = post

      visit categories_path
      click_on post_category
      click_on subject_post.title

      result = page

      expect(result).to have_content(subject_post.body)
    end
  end
end
