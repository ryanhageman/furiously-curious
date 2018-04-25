# frozen_string_literal: true

# Post Model
class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates_presence_of :title, :body, :author_id, :author
end
