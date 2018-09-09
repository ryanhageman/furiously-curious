# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build_stubbed(:post) }

  context 'scopes' do
    it 'visible_posts scope only returns published/visible posts' do
      create_list(:post, 2, :published, :visible)
      create(:post, :published, :unreleased)
      create(:post, :draft, :visible)

      expect(Post.visible_posts.count).to eq(2)
    end

    it 'unreleased_posts only returns published/unreleased posts' do
      create_list(:post, 3, :published, :unreleased)
      create(:post, :published, :visible)
      create(:post, :draft, :unreleased)

      expect(Post.unreleased_posts.count).to eq(3)
    end
  end

  context 'visibility check' do
    it '#visible? true when it is published & publish date is before now' do
      post = create(:post, :published, :visible)

      expect(post.visible?).to be(true)
    end

    it '#wait_to_show? true when publish_date hasnt arrived' do
      post = create(:post, :unreleased)

      expect(post.wait_to_show?).to be(true)
    end

    it '#ready_to_show? true when publish_date is before now' do
      post = create(:post, :visible)

      expect(post.ready_to_show?).to be(true)
    end
  end
end
