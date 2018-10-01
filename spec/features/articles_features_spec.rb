# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Articles Features', type: :feature do
  describe 'user searches articles index' do
    scenario 'they see all the matching articles' do
      subject1 = create(:post, :published, title: 'Lightsaber')
      subject2 = create(:post, :published, title: 'Tiger', body: 'Sabertooth')
      other_post = create(:post, :published, title: 'Jedi')

      visit articles_path
      fill_in 'search', with: 'saber'
      click_on 'Search'

      result = page

      expect(result).to have_content(subject1.title)
      expect(result).to have_content(subject2.title)
      expect(result).not_to have_content(other_post.title)
    end
  end

  describe 'user clicks a tag filter' do
    scenario 'they see all the articles with that tag' do
      tag1 = create(:tag, name: 'activities')
      tag2 = create(:tag, name: 'leisure')
      post1 = create(:post, :published, :with_specific_tag,
                     title: 'Running', tag: tag1)
      post2 = create(:post, :published, :with_specific_tag,
                     title: 'Swimming', tag: tag1)
      post3 = create(:post, :published, :with_specific_tag,
                     title: 'Snoozing', tag: tag2)

      visit articles_path
      click_on tag1.name

      result = page

      expect(result).to have_content(post1.title)
      expect(result).to have_content(post2.title)
      expect(result).not_to have_content(post3.title)
    end
  end

  describe 'user clicks a category filter' do
    scenario 'they see all the articles with that category' do
      category1 = create(:category, name: 'activities')
      category2 = create(:category, name: 'leisure')
      post1 = create(:post, :published, :with_specific_category,
                     title: 'Running', category: category1)
      post2 = create(:post, :published, :with_specific_category,
                     title: 'Swimming', category: category1)
      post3 = create(:post, :published, :with_specific_category,
                     title: 'Snoozing', category: category2)

      visit articles_path
      click_on category1.name

      result = page

      expect(result).to have_content(post1.title)
      expect(result).to have_content(post2.title)
      expect(result).not_to have_content(post3.title)
    end
  end

  describe 'user clicks a post title' do
    scenario 'they can look at a specific post' do
      subject = create(:post, :published)

      visit articles_path
      click_on subject.title

      result = page

      expect(result).to have_content(subject.title, subject.body)
      expect(result).to have_content(subject.author.profile.username)
    end
  end
end
