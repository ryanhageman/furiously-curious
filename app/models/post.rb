# frozen_string_literal: true

# Post Model
class Post < ApplicationRecord
  include AASM

  attr_accessor :raw_tags, :raw_categories, :delete_main_image

  has_one_attached :main_image
  has_many_attached :images

  belongs_to :author, class_name: 'User'
  has_many :post_tags, dependent: :destroy
  has_many :tags, -> { distinct }, through: :post_tags
  has_many :post_categories, dependent: :destroy
  has_many :categories, -> { distinct }, through: :post_categories

  accepts_nested_attributes_for :post_tags, allow_destroy: true
  accepts_nested_attributes_for :post_categories, allow_destroy: true

  validates_presence_of :title, :body, :author_id, :author

  before_validation { main_image.purge if delete_main_image == '1' }

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

  def ready_to_show?
    publish_date < Time.current
  end

  def wait_to_show?
    publish_date > Time.current
  end

  def visible?
    published? && ready_to_show?
  end

  def raw_data_to_array(raw_data)
    raw_data.split(',').map(&:strip)
  end

  def parse_raw_tags(data)
    raw_tags = data[:post][:raw_tags]

    return [] unless raw_tags
    create_tag_id_array(raw_tags)
  end

  def create_tag_id_array(raw_tags)
    get_tag_ids(raw_tags).map { |id| { tag_id: id } }
  end

  def get_tag_ids(raw_tags)
    raw_data_to_array(raw_tags).map do |tag|
      Tag.where(name: tag).first_or_create.id
    end
  end

  def parse_raw_categories(data)
    raw_categories = data[:post][:raw_categories]

    return [] unless raw_categories
    create_category_id_array(raw_categories)
  end

  def create_category_id_array(raw_categories)
    get_category_ids(raw_categories).map { |id| { category_id: id } }
  end

  def get_category_ids(raw_categories)
    raw_data_to_array(raw_categories).map do |category|
      Category.where(name: category).first_or_create.id
    end
  end
end
