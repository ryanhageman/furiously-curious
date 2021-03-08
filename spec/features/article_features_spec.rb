# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Article Features', type: :feature do
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

  describe 'user clicks a post title' do
    scenario 'they can look at a specific post' do
      subject = create(:post, :published)

      visit articles_path
      click_on subject.title

      result = page

      expect(result).to have_content(subject.title)
      expect(result).to have_content(subject.body)
      expect(result).to have_content(subject.author.profile.username)
    end
  end
end
