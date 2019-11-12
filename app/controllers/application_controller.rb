class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def owns_link?(link)
        current_user == link.user
    end
end
