class UserPolicy < ApplicationPolicy

  def index?
    create?
  end

  def create?
    user && user.admin?
  end

  def show?
    (user && user.admin?) ||
    (user.id == user_on_which_to_act.id)
  end

end
