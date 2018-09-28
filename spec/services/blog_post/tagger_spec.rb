# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlogPost::Tagger do
  let(:params) { { post: { raw_tags: 'tag one, tag two' } } }
  let(:tagger) { BlogPost::Tagger.new(params) }

  context '#add_post_tags' do
    it 'creates new tags from raw data' do
      subject = tagger
      tag_array = subject.add_post_tags
      first_tag_id = tag_array.first[:tag_id]

      actual_tag = Tag.find(first_tag_id)
      result = actual_tag.name

      expect(result).to eq('tag one')
    end

    it 'creates an id array of tag_ids' do
      subject = tagger

      tag_array = subject.add_post_tags
      result = tag_array.first.include?(:tag_id)

      expect(result).to be(true)
    end

    it 'returns an empty array when no tag data is given' do
      params = { post: {} }
      subject = BlogPost::Tagger.new(params)

      result = subject.add_post_tags

      expect(result).to eq([])
    end
  end
end
