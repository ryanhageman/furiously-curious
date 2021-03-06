# frozen_string_literal: true

# User Profile Model
class Profile < ApplicationRecord
  attr_accessor :delete_avatar
  belongs_to :user, optional: true

  has_one_attached :avatar
  has_many_attached :post_images

  validates :username, presence: true, uniqueness: true

  before_validation { self.username &&= username.downcase }
  before_validation { avatar.purge if delete_avatar == '1' }

  def self.search_usernames(username)
    where('username ILIKE ?', "%#{username}%")
  end
end
