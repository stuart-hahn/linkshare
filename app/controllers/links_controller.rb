class LinksController < ApplicationController

    skip_before_action :authenticate_user!, only: [:index]

    def index
        if params[:category_id]
            @links = Link.where(category_id: params[:category_id])
        else
            flash.now[:alert] = "That category doesn't exist" if params[:category_id]
            @links = Link.all
        end
    end

    def new
        if params[:category_id] && !Category.exists?(params[:category_id])
          redirect_to categories_path, alert: "Category not found."
        else
          @link = Link.new(category_id: params[:category_id])
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

    def edit
        if params[:category_id]
          category = Category.find_by(id: params[:category_id])
          if category.nil?
            redirect_to categories_path, alert: "Category not found."
          else
            @link = category.links.find_by(id: params[:id])
            redirect_to category_links_path(category), alert: "Link not found." if @link.nil?
          end
        else
          @link = Link.find(params[:id])
        end
    end

    def update
        set_link
        if @link.update(link_params)
            redirect_to link_path(@link)
        else
            render :edit
        end
    end

    def destroy
        link = Link.find_by(id: params[:id])
        if current_user.owns_link?(link)
            link.destroy
            redirect_to root_path, notice: "Link successfully deleted"
        else
            flash[:error] = "You cannot delete that link"
            redirect_back(fallback_location: root_path)
        end
    end

    def show
        set_link
    end

    def upvote
        set_link
        current_user.upvote(@link)

        redirect_back(fallback_location: root_path)
    end

    private

    def set_link
        @link = Link.find_by(id: params[:id])
    end

    def link_params
        params.require(:link).permit(:title, :url, :category_id)
    end
end
