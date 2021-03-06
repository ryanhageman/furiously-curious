# frozen_string_literal: true

# Tag Model
class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true

  before_validation { self.name &&= name.downcase }

  def self.search_names(name)
    where('name ILIKE ?', "%#{name}%")
  end
end
