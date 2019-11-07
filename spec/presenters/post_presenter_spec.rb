# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPresenter do
  let(:view) { ActionController::Base.new.view_context }
  let(:post) { create(:post) }

  describe 'attributes' do
    let(:author) { post.author }
    let(:profile) { create(:profile, user_id: author.id) }

    context '#author_username' do
      it 'returns the authors username when there is one' do
        subject = profile
        presenter = PostPresenter.new(post, view)

        result = presenter.author_username

        expect(result).to eq(subject.username)
      end

      it 'uses GuestUser attributes when no author is assigned' do
        no_author = GuestUser.new
        presenter = PostPresenter.new(post, view)

        result = presenter.author_username

        expect(result).to eq(no_author.profile.username)
      end
    end

    context '#post_tags' do
      let(:tagged_post) { create(:post, :with_tags) }

      it 'returns the a list of tags when the post has been tagged' do
        subject = tagged_post.tags.first.name
        presenter = PostPresenter.new(tagged_post, view)

        result = presenter.post_tags

        expect(result).to include(subject)
      end

      it 'returns "No Tags" when the post has no tags' do
        tagless_post = post
        subject = PostPresenter.new(tagless_post, view)

        result = subject.post_tags

        expect(result).to eq('No Tags')
      end
    end

    context '#post_categories' do
      let(:categorized_post) { create(:post, :with_categories) }

      it 'returns the a list of categories when the post has categories' do
        subject = categorized_post.categories.first.name
        presenter = PostPresenter.new(categorized_post, view)

        result = presenter.post_categories

        expect(result).to include(subject.titleize)
      end

      it 'returns "No Categories" when the post has no categories' do
        uncategorized_post = post
        subject = PostPresenter.new(uncategorized_post, view)

        result = subject.post_categories

        expect(result).to eq('No Categories')
      end
    end
  end
end
