module Settings
  class Setting < ApplicationRecord
    def self.get_setting(key)
      if Current.user
	    Settings::Setting.where(user_id: Current.user.id, key: key).try(:first).try(:value)
	  else
		nil
	  end
    end

    def self.get_system_setting(key)
      Settings::Setting.where(user_id: nil, key: key).try(:first).try(:value)
    end
  end
end
