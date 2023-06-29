class TargetPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    true
  end

  def index?
    true
  end
end
