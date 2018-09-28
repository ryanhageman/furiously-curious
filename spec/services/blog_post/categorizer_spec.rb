# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlogPost::Categorizer do
  let(:params) { { post: { raw_categories: 'category one, category two' } } }
  let(:categorizer) { BlogPost::Categorizer.new(params) }

  context '#add_post_categories' do
    it 'creates new categories from raw data' do
      subject = categorizer
      category_array = subject.add_post_categories
      first_category_id = category_array.first[:category_id]
      actual_category = Category.find(first_category_id)

      result = actual_category.name

      expect(result).to eq('category one')
    end

    it 'creates an id array of category_ids' do
      subject = categorizer
      category_array = subject.add_post_categories

      result = category_array.first.include?(:category_id)

      expect(result).to be(true)
    end

    it 'returns an empty array when no category data is given' do
      params = { post: {} }
      subject = BlogPost::Categorizer.new(params)

      result = subject.add_post_categories

      expect(result).to eq([])
    end
  end
end
