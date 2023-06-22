class TopicPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all if user
    end

    private

    attr_reader :user, :scope
  end

  def index?
    true
  end
end
