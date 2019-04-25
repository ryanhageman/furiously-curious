# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  enum role: %i[user author admin]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy
  has_many :posts, foreign_key: :author_id, inverse_of: :user, dependent: :destroy

  def profile
    super || DefaultProfile.new
  end
end
