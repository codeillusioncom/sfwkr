module Auth
  class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :confirmable, :lockable, :timeoutable, :trackable #,
    #:omniauthable

    resourcify :roles, role_cname: 'Role'

    rolify role_cname: 'Role'
    rolify :before_add => :before_add_method

    after_create :assign_default_role
    after_create :create_settings

    def before_add_method(role)
      # nothing
    end

    private

    def assign_default_role
      self.add_role(:user) if self.roles.blank?
    end

    def create_settings
      Settings::Setting.create(user_id: ENV['SYSTEM_USER_ID'], key: :theme, value: ENV['SYSTEM_THEME']).try(:value)
    end
  end
end
