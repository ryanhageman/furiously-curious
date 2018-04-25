# frozen_string_literal: true

# Post Model
class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates_presence_of :title, :body, :author_id, :author
end
