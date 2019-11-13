# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  context '#search_titles(term)' do
    it 'returns the matching posts' do
      subject1 = create(:post, title: 'Lightsaber')
      subject2 = create(:post, title: 'Sabertooth Tiger')
      other_post = create(:post, title: 'Jedi', body: 'Lightsaber')

      result = Post.search_titles('saber')

      expect(result).to include(subject1, subject2)
      expect(result).not_to include(other_post)
    end
  end

  context '#search_titles_and_body(term)' do
    it 'returns only the matching articles' do
      subject1 = create(:post, :published, title: 'Lightsaber')
      subject2 = create(:post, :published, title: 'Tiger', body: 'Sabertooth')
      other_post = create(:post, :published, title: 'Jedi')

      result = Post.search_titles_and_body('saber')

      expect(result).to include(subject1, subject2)
      expect(result).not_to include(other_post)
    end
  end

  context '#with_specific_tag(params)' do
    it 'returns all the posts with that tag' do
      tag1 = create(:tag)
      tag2 = create(:tag)
      subject1 = create(:post, :with_specific_tag, tag: tag1)
      subject2 = create(:post, :with_specific_tag, tag: tag1)
      other_post = create(:post, :with_specific_tag, tag: tag2)

      result = Post.with_specific_tag(tag1.id)

      expect(result).to include(subject1, subject2)
      expect(result).not_to include(other_post)
    end
  end

  context '#with_specific_category(params)' do
    it 'returns all the posts with that category' do
      category1 = create(:category)
      category2 = create(:category)
      subject1 = create(:post, :with_specific_category, category: category1)
      subject2 = create(:post, :with_specific_category, category: category1)
      other_post = create(:post, :with_specific_category, category: category2)

      result = Post.with_specific_category(category1.id)

      expect(result).to include(subject1, subject2)
      expect(result).not_to include(other_post)
    end
  end

  context '#visible_with_specific_category(params)' do
    it 'returns all the published and visible posts with that category' do
      category1 = create(:category)
      category2 = create(:category)
      subject1 = create(:post, :published, :with_specific_category, category: category1)
      subject2 = create(:post, :with_specific_category, category: category1)
      other_post = create(:post, :with_specific_category, category: category2)

      result = Post.visible_with_specific_category(category1.id)

      expect(result).to include(subject1)
      expect(result).not_to include(subject2, other_post)
    end
  end
end
