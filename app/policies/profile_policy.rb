# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  def index?
    true
  end
  
  def show?
    true
  end

  def new?
    user
  end

  def create?
    user
  end

  def edit?
    users_own_profile?
  end

  def update?
    users_own_profile?
  end

  def destroy?
    users_own_profile?
  end

  private

  def users_own_profile?
    user.profile == record
  end
end
