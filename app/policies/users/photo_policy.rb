# frozen_string_literal: true

class Users::PhotoPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    user.present?
  end

  def show?
    user.id == record.user_id || user.moderator?
  end

  def update?
    user.id == record.user_id || user.moderator?
  end

  def destroy?
    user.id == record.user_id
  end
end
