class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

    protected
    def after_sign_in_path_for(resource)
    	if resource.class.name == "User"
      		products_path
      	elsif resource.class.name == "Admin"
      		request.env['omniauth.origin'] || stored_location_for(resource) || admin_products_path
      	end
    end
end
