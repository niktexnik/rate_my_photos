# frozen_string_literal: true

class Api::CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    current_user == record.user_id
  end

  def destroy?
    current_user == record.user_id
  end
end
