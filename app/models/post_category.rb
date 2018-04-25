# frozen_string_literal: true

# Join table for Posts and Categories
class PostCategory < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :category, optional: true
end
