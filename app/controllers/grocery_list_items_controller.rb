class GroceryListItemsController < ApplicationController
    def index
        @grocery_list_items = GroceryListItem.all

    end
    def show
        @grocery_list_item = GroceryListItem.find(params[:id])
    end

    def new
        @grocery_list_item = GroceryListItem.new
    end

    def create
        @grocery_list_item = GroceryListItem.new(grocery_list_item_params)

        if @grocery_list_item.save
            redirect_to @grocery_list_items_path
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    def destroy
        @grocery_list_item = GroceryListItem.find(params[:id])
        @grocery_list_item.destroy
        redirect_to grocery_list_items_path(@grocery_list_items), notice: "Item deleted successfully"
    end

    def destroy_all
        @grocery_list_items = GroceryListItem.all
        @grocery_list_items.each do |gl_item|
            gl_item.destroy
        end
        
        redirect_to grocery_list_items_path, notice: "All items deleted successfully"
    end
    private
        def grocery_list_item_params
            params.require(:grocery_list_item).permit(:name, :description, :amount_type, :amount, :price, :grocery_type)
        end
end
