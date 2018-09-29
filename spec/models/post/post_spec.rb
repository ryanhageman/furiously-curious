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

  context '#form_friendly_tags' do
    it 'converts tags to a raw_tags string for forms' do
      subject = create(:post, :with_tags)
      tags = subject.tags

      result = subject.form_friendly_tags

      expect(result).to include(tags[0].name, tags[1].name, tags[2].name)
    end
  end

  context '#form_friendly_categories' do
    it 'converts categories to a raw_categories string for forms' do
      subject = create(:post, :with_categories)
      categories = subject.categories

      result = subject.form_friendly_categories

      expect(result).to include(categories[0].name,
                                categories[1].name,
                                categories[2].name)
    end
  end

  context '#clear_taxonomy' do
    it 'deletes all the tags on a post' do
      subject = create(:post, :with_tags)
      subject.clear_taxonomy

      result = subject.post_tags.count

      expect(result).to eq(0)
    end

    it 'deletes all the categories on a post' do
      subject = create(:post, :with_categories)
      subject.clear_taxonomy

      result = subject.post_categories.count

      expect(result).to eq(0)
    end
  end
end
