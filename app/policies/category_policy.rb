# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.admin? || user.author?
  end

  def create?
    user.admin? || user.author?
  end

  def edit?
    user.admin? || (user.author? && author_of_all_posts_in_category?)
  end

  def update?
    user.admin? || (user.author? && author_of_all_posts_in_category?)
  end

  def destroy?
    user.admin?
  end

  private

  def author_of_all_posts_in_category?
    author_ids_in_category.reject { |author_id| author_id == user.id }.empty?
  end

  def author_ids_in_category
    Category.find(record.id).posts.pluck(:author_id)
  end
end
