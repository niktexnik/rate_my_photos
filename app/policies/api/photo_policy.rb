# frozen_string_literal: true

class Api::PhotoPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.id == record.user_id
  end

  def destroy?
    user.id == record.user_id
  end
end
