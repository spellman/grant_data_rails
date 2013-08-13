class ApplicationPolicy
  attr_reader :user, :user_on_which_to_act

  def initialize user, user_on_which_to_act
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @user_on_which_to_act = user_on_which_to_act
  end

  def index?
    false
  end

  def show?
    scope.where(id: user_on_which_to_act.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope! user, user_on_which_to_act.class
  end
end
