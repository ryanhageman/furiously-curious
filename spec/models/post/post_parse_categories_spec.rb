# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build_stubbed(:post) }

  context 'categories' do
    let(:data) { { post: { raw_categories: 'category one, category two' } } }

    describe 'parse_raw_categories' do
      let(:category_array) { post.parse_raw_categories(data) }

      it 'creates new categories from raw data' do
        first_category_id = category_array.first[:category_id]

        expect(Category.find(first_category_id)[:name]).to eq('category one')
      end

      it 'returns an array filled with :category_id hashes' do
        expect(category_array.first.include?(:category_id)).to be(true)
      end

      it 'returns an empty array when no category data is given' do
        no_category_data = { post: {} }

        expect(post.parse_raw_categories(no_category_data)).to eq([])
      end
    end
  end
end
