# frozen_string_literal: true

# Post Model
class Post < ApplicationRecord
  include AASM

  attr_writer :raw_tags, :raw_categories
  attr_accessor :delete_main_image

  has_one_attached :main_image
  has_many_attached :images

  paginates_per 10

  belongs_to :author, class_name: 'User'
  has_many :post_tags, dependent: :destroy
  has_many :tags, -> { distinct }, through: :post_tags
  has_many :post_categories, dependent: :destroy
  has_many :categories, -> { distinct }, through: :post_categories

  accepts_nested_attributes_for :post_tags, allow_destroy: true
  accepts_nested_attributes_for :post_categories, allow_destroy: true

  validates :title, :body, :author_id, presence: true

  before_validation { main_image.purge if delete_main_image == '1' }

  def author
    super || GuestUser.new
  end

  aasm do
    state :draft, initial: true
    state :published, :hidden

    event :save_as_draft do
      transitions from: %i[published hidden], to: :draft
    end

    event :publish do
      before { self.publish_date ||= Time.current }

      transitions from: %i[draft hidden], to: :published
    end

    event :hide do
      transitions from: :published, to: :hidden
    end
  end

  scope :visible_posts, -> { published.select(&:ready_to_show?) }
  scope :unreleased_posts, -> { published.select(&:wait_to_show?) }

  def self.search_titles(term)
    where('title ILIKE ?', "%#{term}%")
  end

  def ready_to_show?
    publish_date < Time.current
  end

  def wait_to_show?
    publish_date > Time.current
  end

  def visible?
    published? && ready_to_show?
  end

  def raw_tags
    tags.map(&:name).join(', ')
  end

  def raw_categories
    categories.map(&:name).join(', ')
  end

  def add_taxonomy(params)
    self.post_tags_attributes = BlogPost::Tagger.new(params).add_post_tags
    self.post_categories_attributes = BlogPost::Categorizer.new(params).add_post_categories
  end

  def update_taxonomy(params)
    clear_taxonomy
    add_taxonomy(params)
  end

  private

  def clear_taxonomy
    post_tags.destroy_all
    post_categories.destroy_all
  end
end
