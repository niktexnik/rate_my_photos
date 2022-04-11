# frozen_string_literal: true

class PhotoPolicy < ApplicationPolicy
  def index?
    true
  end

  def preview?
    true
  end
end
