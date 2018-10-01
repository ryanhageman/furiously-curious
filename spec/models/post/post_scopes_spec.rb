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

    context 'latest' do
      it 'only returns the newest 7 posts' do
        newest_post = create(:post, :published, title: 'Newest Post')
        create_list(:post, 5, :published, created_at: 2.days.ago)
        seventh_newest_post = create(:post, :published,
                                     title: '7th', created_at: 3.days.ago)
        subject = create(:post, :published,
                         title: 'Cloaking Device', created_at: 4.days.ago)

        result = Post.latest

        expect(result).to include(newest_post)
        expect(result).to include(seventh_newest_post)
        expect(result).not_to include(subject)
      end

      it 'returns only published posts' do
        subject = create(:post, :published,  title: 'Published')
        hidden_post = create(:post, :hidden, title: 'Under The Stairs')
        draft_post = create(:post, :draft, title: 'Newborn...')

        result = Post.latest

        expect(result).to include(subject)
        expect(result).not_to include(hidden_post)
        expect(result).not_to include(draft_post)
      end
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
