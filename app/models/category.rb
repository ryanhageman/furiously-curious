# frozen_string_literal: true

# Category Model
class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  before_validation { self.name &&= name.downcase }
end
