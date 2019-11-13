class CategoriesController < ApplicationController
    def index
        @categories = Category.all
    end

    def show
        @category = Category.find_by(id: params[:id])
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to category_path(@category), notice: "Category successfully created"
        else
            render :new, alert: "Failed to create category"
        end
    end

    def edit
        @category = Category.find_by(id: params[:id])
    end

    def update
        @category = Category.find_by(id: params[:id])
        if @category.update(category_params)
            redirect_to category_path(@category), notice: "Category succesfully updated"
        else
            render :edit, alert: "Failed to update category"
        end
    end

    def destroy
        @category = Category.find_by(id: params[:id])
        @category.delete
        redirect_to categories_path, notice: "Category successfully deleted"
    end

    private

    def category_params
        params.require(:category).permit(:title)
    end
end
