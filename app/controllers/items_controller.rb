class ItemsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @item = @recipe.items.create(item_params)
    redirect_to recipe_path(@recipe)
end

def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @item = @recipe.items.find(params[:id])
    @item.destroy
    redirect_to recipe_path(@recipe), status: :see_other
end

private
    def item_params
        params.require(:item).permit(:name, :description, :amountType, :amount, :price, :groceryType)
    end
end
