require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    expect(create(:post)).to be_valid
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:author_id) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to belong_to(:author) }
end
