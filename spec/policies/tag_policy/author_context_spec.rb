# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagPolicy do
  subject { described_class.new(user, tag) }

  let(:user) { create(:user, :author) }
  let(:tag) { create(:tag) }
  let(:post) { create(:post, author_id: user.id) }

  context 'author creating a new tag' do
    it { is_expected.to permit_new_and_create_actions }
  end

  context 'author editing tags' do
    before { create(:post_tag, post: post, tag: tag) }

    it 'allowed when tag is used only by the author' do
      post2 = create(:post, author_id: user.id)
      create(:post_tag, post: post2, tag: tag)

      expect(subject).to permit_edit_and_update_actions
    end

    it 'forbidden when tag is used by other authors' do
      user2 = create(:user, :author)
      user2_post = create(:post, author_id: user2.id)
      create(:post_tag, post: user2_post, tag: tag)

      expect(subject).to forbid_edit_and_update_actions
    end
  end

  context 'author destroying a tag' do
    it 'allowed when there are no associated posts' do
      expect(subject).to permit_action(:destroy)
    end

    it 'forbidden when there are associated posts' do
      create(:post_tag, post: post, tag: tag)

      expect(subject).not_to permit_action(:destroy)
    end
  end
end
