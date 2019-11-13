# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles requests' do
  describe 'the articles index' do
    it 'returns only published posts' do
      subject = create(:post, :published,  title: 'Published')
      hidden_post = create(:post, :hidden, title: 'Under The Stairs')
      draft_post = create(:post, :draft, title: 'Newborn...')

      get articles_path

      result = response.body

      expect(result).to include(subject.title)
      expect(result).not_to include(hidden_post.title)
      expect(result).not_to include(draft_post.title)
    end
  end
end
