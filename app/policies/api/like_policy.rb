# frozen_string_literal: true

class Api::LikePolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    current_user == record.user_id
  end
end
