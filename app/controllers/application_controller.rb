class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if (resource.is_admin?)
      # '/admin/dashboard'
      '/admin/products'
    else
      stored_location_for(resource) || '/'
    end
  end

  protected

  def configure_permitted_parameters
  	added_attrs = %i[vendor name lastname email password password_confirmation contact address postalcode city bankaccount bankname bankowner carnet]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
