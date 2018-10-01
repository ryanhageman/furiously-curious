# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Accounts::Profiles requests' do
  let(:current_user) { create(:user, :admin) }

  before { login_as current_user }

  describe 'the Accounts::Profiles index' do
    it 'returns all the profiles' do
      second_user = create(:user)
      subject1 = create(:profile,
                        username: 'first_user',
                        user_id: current_user.id)
      subject2 = create(:profile,
                        username: 'second_user',
                        user_id: second_user.id)

      get accounts_profiles_path

      result = response.body

      expect(result).to include(subject1.username, subject2.username)
    end
  end
end
