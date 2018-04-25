# frozen_string_literal: true

# Tag Model
class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  before_validation { self.name &&= name.downcase }
end
