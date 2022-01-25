# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user&.moderator? || user&.id == record.user_id
  end

  def destroy?
    user&.moderator? || user&.id == record.user_id
  end
end
