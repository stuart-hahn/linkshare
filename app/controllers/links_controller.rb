class LinksController < ApplicationController

    skip_before_action :authenticate_user!, only: [:index]

    def index
        @links = Link.all
    end

    def new
        @link = Link.new
    end

    def create
        @link = current_user.links.build(link_params)
        if @link.save
            redirect_to link_path(@link), notice: "Link successfully created"
        else
            render :new, alert: "Failed to created link"
        end
    end

    def show
        @link = Link.find_by(id: params[:id])
    end

    private

    def link_params
        params.require(:link).permit(:title, :url, :category_id)
    end
end
