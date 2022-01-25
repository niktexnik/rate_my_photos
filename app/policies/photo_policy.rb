# frozen_string_literal: true

class PhotoPolicy < ApplicationPolicy
  def index?
    true
  end

  def preview?
    true
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
