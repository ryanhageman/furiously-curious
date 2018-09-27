# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build_stubbed(:post) }

  context 'categories' do
    let(:data) { { post: { raw_categories: 'category one, category two' } } }

    describe 'parse_raw_categories' do
      let(:category_array) { post.parse_raw_categories(data) }

      it 'creates new categories from raw data' do
        subject_id = category_array.first[:category_id]

        result = Category.find(subject_id)

        expect(result.name).to eq('category one')
      end

      it 'returns an array filled with :category_id hashes' do
        result = category_array.first.include?(:category_id)

        expect(result).to be(true)
      end

      it 'returns an empty array when no category data is given' do
        subject = { post: {} }

        result = post.parse_raw_categories(subject)

        expect(result).to eq([])
      end
    end
  end
end
