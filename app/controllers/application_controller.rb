class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        if (resource.is_admin?)
            '/admin/dashboard'
        else
            stored_location_for(resource) || '/'
        end
    end
end
