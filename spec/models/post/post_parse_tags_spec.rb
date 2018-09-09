# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build_stubbed(:post) }

  context 'tags' do
    let(:data) { { post: { raw_tags: 'tag one, tag two' } } }

    describe 'parse_raw_tags' do
      let(:tag_array) { post.parse_raw_tags(data) }

      it 'creates new tags from raw data' do
        first_tag_id = tag_array.first[:tag_id]

        expect(Tag.find(first_tag_id)[:name]).to eq('tag one')
      end

      it 'returns an array filled with :tag_id hashes' do
        expect(tag_array.first.include?(:tag_id)).to be(true)
      end

      it 'returns an empty array when no tag data is given' do
        no_tag_data = { post: {} }

        expect(post.parse_raw_tags(no_tag_data)).to eq([])
      end
    end
  end
end
