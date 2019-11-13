class CategoriesController < ApplicationController

    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def index
        @categories = Category.all
    end

    def show
    end

    def new
        @category = Category.new
    end

    def create
        @category = current_user.categories.build(category_params)
        if @category.save
            redirect_to category_path(@category), notice: "Category successfully created"
        else
            render :new, alert: "Failed to create category"
        end
    end

    def edit
    end

    def update
        if @category.update(category_params)
            redirect_to category_path(@category), notice: "Category succesfully updated"
        else
            render :edit, alert: "Failed to update category"
        end
    end

    def destroy
        @category.destroy
        redirect_to categories_path, notice: "Category successfully deleted"
    end

    private

    def set_category
        @category = Category.find_by(id: params[:id])
    end

    def category_params
        params.require(:category).permit(:title, :user_id)
    end
end
