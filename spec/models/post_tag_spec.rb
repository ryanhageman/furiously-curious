# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostTag, type: :model do
  it 'has a valid factory' do
    expect(create(:post_tag)).to be_valid
  end

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:tag) }
end
