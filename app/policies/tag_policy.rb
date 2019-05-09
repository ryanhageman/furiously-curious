# frozen_string_literal: true

class TagPolicy < ApplicationPolicy
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
    user.admin? || (user.author? && author_of_all_posts_with_tag?)
  end

  def update?
    user.admin? || (user.author? && author_of_all_posts_with_tag?)
  end

  def destroy?
    user.admin? || (user.author? && tag_has_no_associated_posts)
  end

  private

  def author_of_all_posts_with_tag?
    author_ids_with_tag.reject { |author_id| author_id == user.id }.empty?
  end

  def author_ids_with_tag
    Tag.find(record.id).posts.pluck(:author_id)
  end

  def tag_has_no_associated_posts
    Tag.find(record.id).posts.empty?
  end
end
