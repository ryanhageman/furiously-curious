# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles requests' do
  describe 'the blog root' do
    it 'returns the 7 newest posts' do
      newest_post = create(:post, :published, title: 'Newest Post')
      create_list(:post, 5, :published, created_at: 2.days.ago)
      seventh_newest_post = create(:post, :published,
                                   title: '7th', created_at: 3.days.ago)
      subject = create(:post, :published,
                       title: 'Cloaking Device', created_at: 4.days.ago)

      get recent_path

      result = response.body

      expect(result).to include(newest_post.title)
      expect(result).to include(seventh_newest_post.title)
      expect(result).not_to include(subject.title)
    end

    it 'returns only published posts' do
      subject = create(:post, :published,  title: 'Published')
      hidden_post = create(:post, :hidden, title: 'Under The Stairs')
      draft_post = create(:post, :draft, title: 'Newborn...')

      get recent_path

      result = response.body

      expect(result).to include(subject.title)
      expect(result).not_to include(hidden_post.title)
      expect(result).not_to include(draft_post.title)
    end
  end
end
