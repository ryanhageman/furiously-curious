# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Category Features', type: :feature do
  let(:current_user) { create(:user) }

  before { login_as current_user }

  describe 'user visits the category index' do
    let(:category1) { create(:category, name: 'category one') }
    let(:category2) { create(:category, name: 'category two') }

    scenario 'they see a list of all the categories' do
      subject1 = category1
      subject2 = category2

      visit categories_path

      result = page

      expect(result).to have_content(subject1.name)
      expect(result).to have_content(subject2.name)
    end

    scenario 'they create a new category' do
      visit categories_path
      click_on 'New Category'
      fill_in 'Name', with: 'the new category'
      click_on 'Create Category'

      result = page

      expect(result).to have_content('the new category')
    end

    scenario 'they edit a category' do
      subject = category1
      other_category = category2

      visit categories_path
      click_on subject.name
      fill_in 'Name', with: 'Updated category'
      click_on 'Update Category'

      result = page

      expect(result).to have_content('updated category')
      expect(result).to have_content(other_category.name)
    end

    scenario 'they destroy a category' do
      subject = category1
      other_category = category2

      visit categories_path

      expect(page).to have_content(subject.name)

      click_on 'Delete', match: :first

      result = page

      expect(result).not_to have_content(subject.name)
      expect(result).to have_content(other_category.name)
    end
  end
end
