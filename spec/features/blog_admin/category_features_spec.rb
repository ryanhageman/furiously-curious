# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Category Features', type: :feature do
  let(:current_user) { create(:user, :admin) }

  before { login_as current_user }

  describe 'user searches admin categories index' do
    scenario 'they see all the matching categories' do
      subject1 = create(:category, name: 'wolverine bit some poutin')
      subject2 = create(:category, name: 'gambit')
      other_category = create(:category, name: 'beast')

      visit blog_admin_categories_path
      fill_in 'search',	with: 'bit'
      click_on 'Search'

      result = page

      expect(result).to have_content(/#{subject1.name}/i)
      expect(result).to have_content(/#{subject2.name}/i)
      expect(result).not_to have_content(/#{other_category.name}/i)
    end
  end

  describe 'admin visits the category index' do
    let(:category1) { create(:category, name: 'category one') }
    let(:category2) { create(:category, name: 'category two') }

    scenario 'they create a new category' do
      visit blog_admin_categories_path
      click_on 'New Series'
      fill_in 'Name', with: 'the new category'
      click_on 'Create Category'

      result = page

      expect(result).to have_content('The New Category')
    end

    scenario 'they edit a category' do
      subject = category1
      other_category = category2

      visit blog_admin_categories_path
      click_on subject.name.titleize
      click_on 'Edit'
      fill_in 'Name', with: 'Updated category'
      click_on 'Update Category'

      result = page

      expect(result).to have_content(/updated category/i)
      expect(result).to have_content(/#{other_category.name}/i)
    end

    scenario 'they destroy a category' do
      subject = category1
      other_category = category2

      visit blog_admin_categories_path

      expect(page).to have_content(/#{subject.name}/i)

      click_on 'Delete', match: :first

      result = page

      expect(result).not_to have_content(/#{subject.name}/i)
      expect(result).to have_content(/#{other_category.name}/i)
    end
  end
end
