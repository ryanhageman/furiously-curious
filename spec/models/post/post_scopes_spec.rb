# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build_stubbed(:post) }

  context 'scopes' do
    it 'visible_posts scope only returns published/visible posts' do
      create_list(:post, 2, :published, :visible)
      create(:post, :published, :unreleased)
      create(:post, :draft, :visible)

      result = Post.visible_posts.count

      expect(result).to eq(2)
    end

    it 'unreleased_posts only returns published/unreleased posts' do
      create_list(:post, 3, :published, :unreleased)
      create(:post, :published, :visible)
      create(:post, :draft, :unreleased)

      result = Post.unreleased_posts.count

      expect(result).to eq(3)
    end
  end

  context 'visibility check' do
    it '#visible? true when it is published & publish date is before now' do
      subject = create(:post, :published, :visible)

      result = subject.visible?

      expect(result).to be(true)
    end

    it '#wait_to_show? true when publish_date hasnt arrived' do
      subject = create(:post, :unreleased)

      result = subject.wait_to_show?

      expect(result).to be(true)
    end

    it '#ready_to_show? true when publish_date is before now' do
      subject = create(:post, :visible)

      result = subject.ready_to_show?

      expect(result).to be(true)
    end
  end
end
