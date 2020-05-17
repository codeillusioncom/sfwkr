class HomePolicy < Auth::ApplicationPolicy
  def show?
    true
  end
end