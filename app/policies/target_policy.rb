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

  def destroy?
    user.targets.include?(record)
  end
end
