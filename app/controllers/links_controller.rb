class LinksController < ApplicationController

    skip_before_action :authenticate_user!, only: [:index]

    def index
        if there_is_category?
            @links = @category.links
        else
            flash.now[:alert] = "That category doesn't exist" if params[:category_id]
            @links = Link.all
        end
    end

    def new
        if there_is_category?
            @link = @category.links.build
        else
            @link = Link.new
        end
    end

    def create
        @link = current_user.links.build(link_params)
        if @link.save
            redirect_to link_path(@link), notice: "Link successfully created"
        else
            flash.now[:alert] = "Failed to created link"
            render :new
        end
    end

    def destroy
        @link = Link.find_by(id: params[:id])
        if current_user.owns_link?(@link)
            @link.destroy
            redirect_to root_path, notice: "Link successfully deleted"
        else
            flash[:error] = "You cannot delete that link"
            redirect_back(fallback_location: root_path)
        end
    end

    def show
        @link = Link.find_by(id: params[:id])
    end

    private

    def link_params
        params.require(:link).permit(:title, :url, :category_id)
    end

    def there_is_category?
        params[:category_id] && @category = Category.find_by(id: params[:category_id])
    end
end
