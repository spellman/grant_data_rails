class UserPolicy < ApplicationPolicy
  def index?
    create?
  end

  def create?
    user && user.admin?
  end

  def show?
    create? ||
      (object_on_which_to_act.is_a?(User) && user.id == object_on_which_to_act.id)
  end

  def update?
    show?
  end

  def destroy?
    create? && user.id != object_on_which_to_act.id
  end
end
