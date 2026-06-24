class SiteSettingsController < ApplicationController
  skip_before_action :authenticate_request, only: [:show]
  
  # GET /site_settings
  def show
    render json: SiteSetting.current
  end

  # PATCH /site_settings
  def update
    setting = SiteSetting.current
    if setting.update(site_setting_params)
      render json: setting
    else
      render json: setting.errors, status: :unprocessable_entity
    end
  end

  private

  def site_setting_params
    params.require(:site_setting).permit(:booking_cutoff_minutes)
  end
end
