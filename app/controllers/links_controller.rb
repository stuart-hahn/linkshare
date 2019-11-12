class LinksController < ApplicationController
    skip_before_action :authenticate_user!, only: :index
    def index
        @links = Link.all
    end
end
