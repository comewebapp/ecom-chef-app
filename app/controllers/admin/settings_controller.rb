class Admin::SettingsController < Admin::ApplicationController

  before_action :set_setting, only: [:index, :create, :update]

  def index
  end

  def create
    if @setting.update(setting_params)
      redirect_to "/admin/settings", notice: 'Setting was successfully update'
    else
      render :edit
    end
  end

  def update
    if @setting.update(setting_params)
      redirect_to "/admin/settings", notice: 'Setting was successfully update'
    else
      render :edit
    end
  end

  def reset_stock
    redirect_to admin_settings_path
  end

  private

  def set_setting
    @setting = Setting.current
  end

  def setting_params
    params.require(:setting).permit(:delivery_price)
  end

end