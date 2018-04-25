# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'has a valid factory' do
    expect(create(:tag)).to be_valid
  end

  it { is_expected.to have_many(:post_tags) }
  it { is_expected.to have_many(:posts) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
end
