# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPresenter do
  let(:view) { ActionController::Base.new.view_context }
  let(:post) { create(:post) }

  describe 'attributes' do
    let(:author) { post.author }
    let(:profile) { create(:profile, user_id: author.id) }
    let(:presenter) { PostPresenter.new(post, view) }

    context '#author_username' do
      it 'returns the authors username when there is one' do
        author_profile = profile
        expect(presenter.author_username).to eq(author_profile.username)
      end

      it 'returns "Anonymous" when no author is assigned' do
        expect(presenter.author_username).to eq('Anonymous')
      end
    end

    context '#post_tags' do
      let(:tagged_post) { create(:post, :with_tags) }

      it 'returns the a list of tags when the post has been tagged' do
        presenter = PostPresenter.new(tagged_post, view)
        first_tag = tagged_post.tags.first.name

        expect(presenter.post_tags).to include(first_tag)
      end

      it 'returns "No Tags" when the post has no tags' do
        expect(presenter.post_tags).to eq('No Tags')
      end
    end

    context '#post_categories' do
      let(:categorized_post) { create(:post, :with_categories) }
      
      it 'returns the a list of categories when the post has categories' do
        presenter = PostPresenter.new(categorized_post, view)
        first_category = categorized_post.categories.first.name

        expect(presenter.post_categories).to include(first_category)
      end

      it 'returns "No Categories" when the post has no tags' do
        expect(presenter.post_categories).to eq('No Categories')
      end
    end
  end
end
