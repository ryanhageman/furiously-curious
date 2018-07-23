# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build_stubbed(:post) }
  it 'has a valid factory' do
    expect(create(:post)).to be_valid
  end

  it { is_expected.to belong_to(:author) }
  it { is_expected.to have_many(:post_tags) }
  it { is_expected.to have_many(:tags) }
  it { is_expected.to have_many(:post_categories) }
  it { is_expected.to have_many(:categories) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:author_id) }
  it { is_expected.to validate_presence_of(:author) }

  context 'state' do
    it 'should go from draft to published' do
      expect(post).to transition_from(:draft).to(:published).on_event(:publish)
    end

    it 'should go from hidden to published' do
      expect(post).to transition_from(:hidden).to(:published).on_event(:publish)
    end

    it 'should go from published to hidden' do
      expect(post).to transition_from(:published).to(:hidden).on_event(:hide)
    end

    it 'should not go from draft to hidden' do
      expect(post).not_to allow_event(:hide)
    end

    it 'should go from published to draft' do
      expect(post)
        .to transition_from(:published)
        .to(:draft)
        .on_event(:save_as_draft)
    end

    it 'should go from hidden to draft' do
      expect(post).to(
        transition_from(:hidden)
        .to(:draft)
        .on_event(:save_as_draft)
      )
    end
  end

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

  describe 'raw_data_to_array' do
    it 'splits a raw data string into an array' do
      data_string = 'first tag, second, third cat e gory here'

      expect(post.raw_data_to_array(data_string).count).to eq(3)
    end
  end

  context 'tags' do
    let(:data) { { post: { raw_tags: 'tag one, tag two' } } }

    describe 'parse_raw_tags' do
      let(:tag_array) { post.parse_raw_tags(data) }

      it 'creates new tags from raw data' do
        first_tag_id = tag_array.first[:tag_id]

        expect(Tag.find(first_tag_id)[:name]).to eq('tag one')
      end

      it 'returns an array filled with :tag_id hashes' do
        expect(tag_array.first.include?(:tag_id)).to be(true)
      end

      it 'returns an empty array when no tag data is given' do
        no_tag_data = { post: {} }

        expect(post.parse_raw_tags(no_tag_data)).to eq([])
      end
    end

    describe 'create_tag_id_array' do
      let(:raw_tag_string) { 'first tag, second tag' }
      let(:tag_id_array) do
        post.create_id_array(raw_tag_string, Tag, 'name', 'tag_id')
      end

      it 'creates an array of tag ids' do
        expect(tag_id_array.first.include?(:tag_id)).to be(true)
      end

      it 'creates two tags' do
        expect(tag_id_array.count).to eq(2)
      end
    end

    describe 'get_tag_ids' do
      let(:raw_tag_string) { 'first tag here, second, third tag' }
      let(:tag_id_array) { post.get_ids(raw_tag_string, Tag, 'name') }

      it 'returns 3 tag ids' do
        expect(tag_id_array.count).to eq(3)
      end

      it 'returns valid tag ids' do
        expect(Tag.find(tag_id_array.first).class).to eq(Tag)
      end
    end
  end

  context 'categories' do
    let(:data) { { post: { raw_categories: 'category one, category two' } } }

    describe 'parse_raw_categories' do
      let(:category_array) { post.parse_raw_categories(data) }

      it 'creates new categories from raw data' do
        first_category_id = category_array.first[:category_id]

        expect(Category.find(first_category_id)[:name]).to eq('category one')
      end

      it 'returns an array filled with :category_id hashes' do
        expect(category_array.first.include?(:category_id)).to be(true)
      end

      it 'returns an empty array when no category data is given' do
        no_category_data = { post: {} }

        expect(post.parse_raw_categories(no_category_data)).to eq([])
      end
    end

    describe 'create_category_id_array' do
      let(:raw_categories) { 'first category, second category' }
      let(:category_id_array) do
        post.create_id_array(raw_categories, Category, 'name', 'category_id')
      end

      it 'creates an array of category ids' do
        expect(category_id_array.first.include?(:category_id)).to be(true)
      end

      it 'creates two categories' do
        expect(category_id_array.count).to eq(2)
      end
    end

    describe 'get_category_ids' do
      let(:raw_categories) { 'first cat e gory, second, third category' }
      let(:category_id_array) do
        post.get_ids(raw_categories, Category, 'name')
      end

      it 'returns 3 category ids' do
        expect(category_id_array.count).to eq(3)
      end

      it 'returns valid category ids' do
        expect(Category.find(category_id_array.first).class).to eq(Category)
      end
    end
  end
end
