# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tag Features', type: :feature do
  let(:current_user) { create(:user) }

  before { login_as current_user }

  describe 'user visits the tag index' do
    let(:tag1) { create(:tag, name: 'tag one') }
    let(:tag2) { create(:tag, name: 'tag two') }

    scenario 'user creates a new tag' do
      visit blog_admin_tags_path
      click_on 'New Tag'
      fill_in 'Name', with: 'the new tag'
      click_on 'Create Tag'

      results = page

      expect(results).to have_content('the new tag')
    end

    scenario 'user edits a tag' do
      subject = tag1
      other_tag = tag2

      visit blog_admin_tags_path
      click_on subject.name
      fill_in 'Name', with: 'Updated tag'
      click_on 'Update Tag'

      results = page

      expect(results).to have_content('updated tag')
      expect(results).to have_content(other_tag.name)
    end

    scenario 'user destroys a tag' do
      subject = tag1
      other_tag = tag2

      visit blog_admin_tags_path

      expect(page).to have_content(subject.name)

      click_on 'Delete', match: :first

      results = page

      expect(results).not_to have_content(subject.name)
      expect(results).to have_content(other_tag.name)
    end
  end
end
