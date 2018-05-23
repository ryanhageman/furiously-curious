# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Category Features', type: :feature do
  let(:current_user) { create(:user) }

  before { login_as current_user }

  describe 'user visits the category index' do
    before do
      create(:category, name: 'first category')
      create(:category, name: 'second category')
    end

    scenario 'they see a list of all the categories' do
      visit categories_path

      expect(page).to have_content('first category')
      expect(page).to have_content('second category')
    end

    scenario 'they create a new category' do
      visit categories_path

      click_on 'New Category'

      fill_in 'Name', with: 'the new category'
      click_on 'Create Category'

      expect(page).to have_content('the new category')
    end

    scenario 'they edit a category' do
      visit categories_path

      click_on 'first category'

      fill_in 'Name', with: 'Updated category'
      click_on 'Update Category'

      expect(page).to have_content('updated category')
      expect(page).to have_content('second category')
    end

    scenario 'they destroy a category' do
      visit categories_path

      expect(page).to have_content('first category')

      click_on 'Delete', match: :first

      expect(page).not_to have_content('first category')
      expect(page).to have_content('second category')
    end
  end
end
