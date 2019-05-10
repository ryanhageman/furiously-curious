# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BlogAdmin::Tag requests' do
  let(:current_user) { create(:user, :admin) }

  before { login_as current_user }

  describe 'the Tags index' do
    it 'returns all the tags' do
      subject1 = create(:tag, name: 'tag one')
      subject2 = create(:tag, name: 'tag two')

      get blog_admin_tags_path

      result = response.body

      expect(result).to include(subject1.name, subject2.name)
    end
  end
end
