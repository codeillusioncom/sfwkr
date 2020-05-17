module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_authenticated_user
  end

  private

  def set_current_authenticated_user
    Current.user = Auth::User.where(id: cookies.signed[:user_id]).try(:first)
  end
end