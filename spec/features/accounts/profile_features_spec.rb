# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Profile Features', type: :feature do
  let(:current_user) { create(:user) }

  before { login_as current_user }

  describe 'user searches the profiles index' do
    scenario 'they see all the matching profiles' do
      subject1 = create(:profile, username: 'Nitty')
      subject2 = create(:profile, username: 'Gritty')
      other_profile = create(:profile, username: 'Funk')

      visit accounts_profiles_path
      fill_in 'search',	with: 'itty'
      click_on 'Search'

      result = page

      expect(result).to have_content(subject1.username)
      expect(result).to have_content(subject2.username)
      expect(result).not_to have_content(other_profile.username)
    end
  end

  describe 'user clicks a profile name' do
    scenario 'they see the full profile' do
      subject = 'My name is Luka. I live on the second floor'
      profile = create(:profile, bio: subject)

      visit accounts_profiles_path
      click_on profile.username

      result = page

      expect(result).to have_content(subject)
    end

    scenario 'they can edit their own profile' do
      profile = create(:profile, :full_profile, user_id: current_user.id)

      visit accounts_profiles_path
      click_on profile.username
      click_on 'Edit your profile'

      fill_in "First name",	with: 'Delicious'
      fill_in "Last name",	with: 'Churros!'

      click_on 'Update Profile'

      result = page

      expect(result).to have_content('Delicious Churros!')
    end

    scenario 'there is no link to edit another users profile' do
      profile = create(:profile, username: '@thanos')

      visit accounts_profiles_path
      click_on profile.username

      result = page

      expect(result).not_to have_content('Edit your profile')
    end

    scenario 'they can delete their own profile' do
      profile = create(:profile, user_id: current_user.id)

      visit accounts_profiles_path
      click_on profile.username
      click_on 'Delete your profile'

      visit accounts_profiles_path

      result = page

      expect(result).not_to have_content(profile.username)
    end

    scenario 'they can not delete other users profiles' do
      profile = create(:profile, username: '@thanos')

      visit accounts_profiles_path
      click_on profile.username

      result = page

      expect(result).not_to have_content('Delete your profile')
    end
  end
end
