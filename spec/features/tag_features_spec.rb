# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tag Features', type: :feature do
  let(:current_user) { create(:user) }

  before { login_as current_user }

  describe 'user visits the tag index' do
    before do
      create(:tag, name: 'first tag')
      create(:tag, name: 'second tag')
    end

    scenario 'they see a list of all the tags' do
      visit tags_path

      expect(page).to have_content('first tag')
      expect(page).to have_content('second tag')
    end

    scenario 'user creates a new tag' do
      visit tags_path

      click_on 'New Tag'

      fill_in 'Name', with: 'the first tag'
      click_on 'Create Tag'

      expect(page).to have_content('the first tag')
    end

    scenario 'user edits a tag' do
      visit tags_path

      click_on 'first tag'

      fill_in 'Name', with: 'Updated tag'
      click_on 'Update Tag'

      expect(page).to have_content('updated tag')
      expect(page).to have_content('second tag')
    end

    scenario 'user destroys a tag' do
      visit tags_path

      expect(page).to have_content('first tag')

      click_on 'Delete', match: :first

      expect(page).not_to have_content('first tag')
      expect(page).to have_content('second tag')
    end
  end

end
