# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(create(:user)).to be_valid
  end

  it { is_expected.to have_one(:profile) }
  it { is_expected.to have_many(:posts).with_foreign_key('author_id') }

  context 'Profile Null Object' do
    it 'returns a DefaultProfile when user.profile is nil' do
      user = build_stubbed(:user, profile: nil)
      expect(user.profile).to be_an_instance_of(DefaultProfile)
    end
  end
end
