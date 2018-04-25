# frozen_string_literal: true

# Join table for Posts and Tags
class PostTag < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :tag, optional: true
end
