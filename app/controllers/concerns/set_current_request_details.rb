module SetCurrentRequestDetails
  extend ActiveSupport::Concern

  included do
    before_action do
      Current.request_id = request.uuid
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
      Current.user = current_user
      Current.company = current_user.try(:current_company?)
      Current.params = params
      # Current.timezone =
      Current.language = I18n.locale
      # Time.zone = person.try(:time_zone)
    end
  end
end