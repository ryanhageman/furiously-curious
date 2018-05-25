# frozen_string_literal: true

# Post Model
class Post < ApplicationRecord
  attr_accessor :raw_tags, :raw_categories
  belongs_to :author, class_name: 'User'
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :post_categories
  has_many :categories, through: :post_categories

  has_one_attached :main_image
  has_many_attached :images

  validates_presence_of :title, :body, :author_id, :author
end
