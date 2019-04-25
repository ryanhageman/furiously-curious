# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryPolicy do
  subject { described_class.new(user, category) }

  let(:user) { create(:user, :author) }
  let(:category) { create(:category) }
  let(:post) { create(:post, author_id: user.id) }

  context 'author creating a new category' do
    it { is_expected.to permit_new_and_create_actions }
  end

  context 'author destroying a category' do
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'author editing categories' do
    before(:each) { create(:post_category, post: post, category: category) }

    it 'allows editing categories used only by the author' do
      post2 = create(:post, author_id: user.id)
      create(:post_category, post: post2, category: category)

      expect(subject).to permit_edit_and_update_actions
    end

    it 'forbids editing categories used by other authors' do
      user2 = create(:user, :author)
      user2_post = create(:post, author_id: user2.id)
      create(:post_category, post: user2_post, category: category)

      expect(subject).to forbid_edit_and_update_actions
    end
  end
end
