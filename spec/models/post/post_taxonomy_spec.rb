# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  context '#raw_tags' do
    it 'converts tags to a raw_tags string for forms' do
      subject = create(:post, :with_tags)
      tags = subject.tags

      result = subject.raw_tags

      expect(result).to include(tags[0].name, tags[1].name, tags[2].name)
    end
  end

  context '#raw_categories' do
    it 'converts categories to a raw_categories string for forms' do
      subject = create(:post, :with_categories)
      categories = subject.categories

      result = subject.raw_categories

      expect(result).to include(categories[0].name,
                                categories[1].name,
                                categories[2].name)
    end
  end

  context '#add_taxonomy' do
    let(:subject) { create(:post) }
    it 'creates associated tags from the raw_tags' do
      params = { post: { raw_tags: 'rick, michonne' } }

      subject.add_taxonomy(params)
      first_tag_id = subject.post_tags.first.tag_id
      result = Tag.find(first_tag_id).name

      expect(result).to eq('rick')
    end

    it 'creates assigns all the tags to the post' do
      params = { post: { raw_tags: 'glenn, maggie, negan' } }

      subject.add_taxonomy(params)
      result = subject.post_tags.length

      expect(result).to eq(3)
    end

    it 'creates associated categories from the raw_categories' do
      params = { post: { raw_categories: 'adventure, time' } }

      subject.add_taxonomy(params)
      first_category_id = subject.post_categories.first.category_id
      result = Category.find(first_category_id).name

      expect(result).to eq('adventure')
    end

    it 'creates assigns all the categories to the post' do
      params = { post: { raw_categories: 'Finn, Jake, BMO' } }

      subject.add_taxonomy(params)
      result = subject.post_categories.length

      expect(result).to eq(3)
    end
  end

  context '#update_taxonomy' do
    it 'deletes all the tags on a post' do
      subject = create(:post, :with_tags)
      subject.update_taxonomy({})

      result = subject.post_tags.count

      expect(result).to eq(0)
    end

    it 'deletes all the categories on a post' do
      subject = create(:post, :with_categories)
      subject.update_taxonomy({})

      result = subject.post_categories.count

      expect(result).to eq(0)
    end
  end
end
