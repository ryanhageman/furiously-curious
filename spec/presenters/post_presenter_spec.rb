# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPresenter do
  let(:view) { ActionController::Base.new.view_context }
  let(:post) { create(:post) }
  let(:author) { post.author }
  let(:profile) { create(:profile, user_id: author.id)}
  let(:tagged_post) { create(:post, :with_tags) }
  let(:categorized_post) { create(:post, :with_categories) }
  let(:presenter) { PostPresenter.new(post, view) }

  describe 'attributes' do
    context '#author_username' do
      it 'returns the authors username when there is one' do
        author_profile = profile
        expect(presenter.author_username).to eq(author_profile.username)
      end

      it 'returns "No Author" when theres no author assigned' do
        expect(presenter.author_username).to eq('No Author')
      end
    end

    context '#post_tags' do
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

  describe 'change_state_links' do
    it 'returns a link to publish a post for drafts' do
      post = create(:post, :draft)
      presenter = PostPresenter.new(post, view)

      expect(presenter.change_state_links).to include('?new_state=published')
    end

    it 'returns links to save as draft and hide for published posts' do
      post = create(:post, :published)
      presenter = PostPresenter.new(post, view)

      expect(presenter.change_state_links).to include('?new_state=draft')
      expect(presenter.change_state_links).to include('?new_state=hidden')
    end

    it 'returns links to save as draft and publish for hidden posts' do
      post = create(:post, :hidden)
      presenter = PostPresenter.new(post, view)

      expect(presenter.change_state_links).to include('?new_state=draft')
      expect(presenter.change_state_links).to include('?new_state=published')
    end
  end
end
