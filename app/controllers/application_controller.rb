class ApplicationController < ActionController::Base
    # Provided by Devise - authenticates a user or redirects them to login page
    before_action :authenticate_user!
end
