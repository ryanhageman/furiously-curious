# frozen_string_literal: true

# User Profile Model
class Profile < ApplicationRecord
  belongs_to :user, optional: true

  validates :username, presence: true, uniqueness: true

  before_validation { self.username &&= username.downcase }
end
