class Admin::ApplicationController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!
    
    layout 'admin'

    def authenticate_admin!
        unless current_user.is_admin?
            redirect_to "/"
        end
    end
end