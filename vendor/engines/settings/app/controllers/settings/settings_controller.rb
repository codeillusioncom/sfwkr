module Settings
  class SettingsController < ApplicationController
    def index
      @settings = policy_scope(Settings::Setting)
      authorize @settings
    end

    def edit
      @setting = Setting.find(params[:id])
      authorize @setting
    end

    def update
      @setting = Setting.find(params[:id])
      authorize @setting

      params[:setting][:user_id] = current_user.id

      if @setting.update_attributes(permitted_attributes(@setting))
        redirect_to settings.settings_path, notice: 'Setting was successfully updated.'
      else
        render :edit
      end
    end

    private

    def setting_params
      params.require(:setting).permit(policy(@setting).permitted_attributes)
    end
  end
end