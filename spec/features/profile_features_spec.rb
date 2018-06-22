# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Profile Features', type: :feature do
  let(:current_user) { create(:user) }
  let(:user2) { create(:user) }
  let(:first_name) { 'Billy' }
  let(:last_name) { 'Bones' }
  let(:username) { 'the_sea' }
  let(:bio) { 'I be the first mate of the sea itself.' }

  before { login_as current_user }

  describe 'User visits the profile index' do
    scenario 'they see a list of all the profiles' do
      create(:profile, username: 'first_user', user_id: current_user.id)
      create(:profile, username: 'second_user', user_id: user2.id)

      visit accounts_profiles_path

      expect(page).to have_content('first_user')
      expect(page).to have_content('second_user')
    end
  end

  describe 'User visits the profile show view' do
    scenario 'they see the details of the profile' do
      create(
        :profile,
        :full_profile,
        username: 'look_at_me',
        user_id: current_user.id
      )

      visit accounts_profiles_path
      click_on 'look_at_me'

      expect(page).to have_content('Firstname')
      expect(page).to have_content('I like to move it move it!')
    end
  end

  describe 'User creates a new profile' do
    scenario 'they see the details of their new profile' do
      visit edit_user_registration_path

      click_on 'Setup your profile'

      fill_in 'First name', with: first_name
      fill_in 'Last name', with: last_name
      fill_in 'Username', with: username
      fill_in 'Bio', with: bio

      click_on 'Create Profile'

      expect(page).to have_content('Name: Billy Bones')
      expect(page).to have_content("#{bio}")
    end
  end

  describe 'User updates their profile' do
    scenario 'they see their new details' do
      create(:profile, :full_profile, user_id: current_user.id)

      visit edit_user_registration_path

      click_on 'Update your profile'

      fill_in 'First name', with: first_name
      fill_in 'Last name', with: last_name
      fill_in 'Username', with: username
      fill_in 'Bio', with: bio

      click_on 'Update Profile'

      expect(page).to have_content('Name: Billy Bones')
      expect(page).to have_content("#{bio}")
    end
  end
end
