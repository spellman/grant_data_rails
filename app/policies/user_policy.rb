class UserPolicy < ApplicationPolicy
  def index?
    create?
  end

  def create?
    user && user.admin?
  end

  def show?
    create? || user.id == object_on_which_to_act.id
  end

  def update?
    show?
  end

  def destroy?
    create?
  end
end
