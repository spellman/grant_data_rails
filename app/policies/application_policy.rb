class ApplicationPolicy
  attr_reader :user, :object_on_which_to_act

  # First parameter, user, refers to current_user.
  def initialize user, object_on_which_to_act
    raise Pundit::NotAuthorizedError, "Must be logged in." unless user
    @user = user
    @object_on_which_to_act = object_on_which_to_act
  end

  def index?
    false
  end

  def show?
    scope.where(id: object_on_which_to_act.id).exists?
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
    Pundit.policy_scope!(user, object_on_which_to_act.class)
  end
end
