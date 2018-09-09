# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    authors_own_post? || user.admin?
  end

  def new?
    user.author? || user.admin?
  end

  def create?
    user.author? || user.admin?
  end

  def edit?
    authors_own_post? || user.admin?
  end

  def update?
    authors_own_post? || user.admin?
  end

  def destroy?
    authors_own_post? || user.admin?
  end

  private

  def authors_own_post?
    user.author? && user.id == record.author_id
  end
end
