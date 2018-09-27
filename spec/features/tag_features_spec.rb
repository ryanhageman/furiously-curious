# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tag Features', type: :feature do
  let(:current_user) { create(:user) }

  before { login_as current_user }

  describe 'user visits the tag index' do
    let(:tag1) { create(:tag, name: 'tag one') }
    let(:tag2) { create(:tag, name: 'tag two') }

    scenario 'they see a list of all the tags' do
      subject1 = tag1
      subject2 = tag2

      visit tags_path

      expect(page).to have_content(subject1.name)
      expect(page).to have_content(subject2.name)
    end

    scenario 'user creates a new tag' do
      visit tags_path

      click_on 'New Tag'

      fill_in 'Name', with: 'the new tag'
      click_on 'Create Tag'

      expect(page).to have_content('the new tag')
    end

    scenario 'user edits a tag' do
      subject = tag1
      other_tag = tag2

      visit tags_path

      click_on subject.name

      fill_in 'Name', with: 'Updated tag'
      click_on 'Update Tag'

      expect(page).to have_content('updated tag')
      expect(page).to have_content(other_tag.name)
    end

    scenario 'user destroys a tag' do
      subject = tag1
      other_tag = tag2

      visit tags_path

      expect(page).to have_content(subject.name)

      click_on 'Delete', match: :first

      expect(page).not_to have_content(subject.name)
      expect(page).to have_content(other_tag.name)
    end
  end
end
