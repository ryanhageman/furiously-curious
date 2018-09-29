# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    expect(create(:post)).to be_valid
  end

  it { is_expected.to belong_to(:author) }
  it { is_expected.to have_many(:post_tags) }
  it { is_expected.to have_many(:tags) }
  it { is_expected.to have_many(:post_categories) }
  it { is_expected.to have_many(:categories) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:author_id) }

  context 'Author Null Object' do
    it 'returns a GuestUser when author is nil' do
      subject = build_stubbed(:post, author: nil)

      result = subject.author

      expect(result).to be_an_instance_of(GuestUser)
    end
  end
end
