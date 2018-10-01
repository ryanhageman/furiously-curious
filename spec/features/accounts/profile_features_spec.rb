# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Profile Features', type: :feature do
  let(:current_user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:bio) { 'I be the first mate of the sea itself.' }

  before { login_as current_user }

  describe 'User visits the profile show view' do
    scenario 'they see the details of the profile' do
      subject = create(:profile,
                       :full_profile,
                       username: 'look_at_me',
                       user_id: current_user.id)

      visit accounts_profiles_path
      click_on 'look_at_me'

      result = page

      expect(result).to have_content(subject.first_name)
      expect(result).to have_content(subject.bio)
    end
  end

  describe 'User creates a new profile' do
    scenario 'they see the details of their new profile' do
      visit edit_user_registration_path

      click_on 'Setup your profile'

      fill_in 'First name', with: 'Billy'
      fill_in 'Last name', with: 'Bones'
      fill_in 'Username', with: 'billybones'
      fill_in 'Bio', with: bio

      click_on 'Create Profile'

      result = page

      expect(result).to have_content('Billy Bones')
      expect(result).to have_content(bio)
    end
  end

  describe 'User updates their profile' do
    scenario 'they see their new details' do
      create(:profile, :full_profile, user_id: current_user.id)

      visit edit_user_registration_path

      click_on 'Update your profile'

      fill_in 'First name', with: 'Rocky'
      fill_in 'Last name', with: 'Balboa'
      fill_in 'Username', with: 'getemrock!'
      fill_in 'Bio', with: bio

      click_on 'Update Profile'

      result = page

      expect(result).to have_content('Rocky Balboa')
      expect(result).to have_content(bio)
    end
  end
end
