# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  it 'has a valid factory' do
    expect(create(:profile)).to be_valid
  end

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { is_expected.to belong_to(:user) }
end
