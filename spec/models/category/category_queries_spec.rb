# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  context '#search_names(name)' do
    it 'returns the matching categories' do
      subject1       = create(:category, name: 'Finn')
      subject2       = create(:category, name: 'Farmworld Finn')
      other_category = create(:category, name: 'Ice King')

      result = Category.search_names('finn')

      expect(result).to include(subject1, subject2)
      expect(result).not_to include(other_category)
    end
  end
end
