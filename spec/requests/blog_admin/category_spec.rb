# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BlogAdmin::Category requests' do
  let(:current_user) { create(:user, :admin) }

  before { login_as current_user }

  describe 'the category index' do
    it 'they see a list of all the categories' do
      subject1 = create(:category, name: 'category one')
      subject2 = create(:category, name: 'category two')

      get blog_admin_categories_path

      result = response.body

      expect(result).to include(subject1.name.titleize)
      expect(result).to include(subject2.name.titleize)
    end
  end
end
