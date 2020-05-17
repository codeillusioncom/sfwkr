class Current < ActiveSupport::CurrentAttributes
  attribute :company, :user, :request_id, :user_agent, :ip_address, :params, :timezone, :language

  resets { Time.zone = nil }

  def user=(user)
    super
    self.company = user.try(:company) if self
    Time.zone = user.try(:time_zone)
  end
end