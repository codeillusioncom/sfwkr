class ApplicationController < ActionController::Base
  protect_from_forgery
  include Pundit
  include Authentication
  include SetCurrentRequestDetails
  include Devise::Controllers::Helpers

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper Pages::ApplicationHelper

  helper_method :devise_controller?

  before_action :current_cart
  after_action :verify_authorized, unless: ->(controller) { controller.is_a?(::DeviseController) }
  after_action :verify_policy_scoped, only: :index

  theme :set_theme
  layout :set_layout

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || main_app.root_path)
  end

  def current_cart
    if session[:cart_id]
      cart = Webshop::Cart.find_by(:id => session[:cart_id])
      if cart.present?
        @current_cart = cart
      else
        session[:cart_id] = nil
      end
    end

    if session[:cart_id] == nil
      @current_cart = Webshop::Cart.create
      session[:cart_id] = @current_cart.id
    end
  end

  def set_theme
    theme = Settings::Setting.get_system_setting('theme')
    if theme
      return theme
    else
      Settings::Setting.create!(user_id: nil, key: 'theme', value: ENV['SYSTEM_THEME'])
      ThemeManager.new.install(ENV['SYSTEM_THEME'])
      return ENV['SYSTEM_THEME']
    end
  end

  def set_layout
    devise_controller? ? 'signin' : ENV['SYSTEM_THEME']
  end
end
