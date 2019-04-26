# frozen_string_literal: true

# Category Model
class Category < ApplicationRecord
  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true

  before_validation { self.name &&= name.downcase }

  def self.search_names(name)
    where('name ILIKE ?', "%#{name}%")
  end
end
