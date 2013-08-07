class UserPolicy < ApplicationPolicy

  def index?
    create?
  end

  def create?
    user && user.admin?
  end

end
