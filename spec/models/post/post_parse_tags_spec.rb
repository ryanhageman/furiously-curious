# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build_stubbed(:post) }

  context 'tags' do
    let(:data) { { post: { raw_tags: 'tag one, tag two' } } }

    describe 'parse_raw_tags' do
      let(:tag_array) { post.parse_raw_tags(data) }

      it 'creates new tags from raw data' do
        subject_id = tag_array.first[:tag_id]

        result = Tag.find(subject_id)

        expect(result.name).to eq('tag one')
      end

      it 'returns an array filled with :tag_id hashes' do
        result = tag_array.first.include?(:tag_id)

        expect(result).to be(true)
      end

      it 'returns an empty array when no tag data is given' do
        subject = { post: {} }

        result = post.parse_raw_tags(subject)

        expect(result).to eq([])
      end
    end
  end
end
