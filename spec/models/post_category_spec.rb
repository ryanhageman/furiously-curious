# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostCategory, type: :model do
  it 'has a valid factory' do
    expect(create(:post_category)).to be_valid
  end

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:category) }
end
