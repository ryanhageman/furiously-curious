# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tag Features', type: :feature do
  describe 'user searches tags index' do
    scenario 'they see all the matching tags' do
      subject1 = create(:tag, name: 'everybody have fun')
      subject2 = create(:tag, name: 'everybody wang chung')
      other_tag = create(:tag, name: 'tonight')

      visit tags_path
      fill_in 'search',	with: 'everybody'
      click_on 'Search'

      result = page

      expect(result).to have_content(subject1.name)
      expect(result).to have_content(subject2.name)
      expect(result).not_to have_content(other_tag.name)
    end
  end

  let(:post) { create(:post, :published, :with_specific_tag) }

  describe 'user clicks a tag name' do
    scenario 'they see a list of all the articles in a specific tag' do
      subject_tag = post.tags.first
      subject_post = post

      visit tags_path
      click_on subject_tag.name

      result = page

      expect(result).to have_content(subject_tag.name)
      expect(result).to have_content(subject_post.title)
    end

    scenario 'they can click an article in that tag and see it' do
      post_tag = post.tags.first.name
      subject_post = post

      visit tags_path
      click_on post_tag
      click_on subject_post.title

      result = page

      expect(result).to have_content(subject_post.body)
    end
  end
end
