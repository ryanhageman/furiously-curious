# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build_stubbed(:post) }
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
    it 'returns a GuestUser when post.author is nil' do
      post = build_stubbed(:post, author: nil)
      expect(post.author).to be_an_instance_of(GuestUser)
    end
  end
end
