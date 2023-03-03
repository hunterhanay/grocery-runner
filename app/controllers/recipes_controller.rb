class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to root_path, status: :see_other
  end

  def add_items
    @recipe = Recipe.find(params[:id])
    @items = @recipe.items
  
    @items.each do |item|
      grocery_list = item.grocery_list || item.build_grocery_list
      grocery_list.items.create(
        name: item.name,
        description: item.description,
        amount_type: item.amount_type,
        amount: item.amount,
        price: item.price,
        grocery_type: item.grocery_type
      )
    end
  
    respond_to do |format|
      format.js { render "add_items.js.erb" }
    end
  end
#   In this code, the add_items action finds the recipe based on the params[:id] parameter sent by the AJAX request. 
#   It then retrieves the items associated with the recipe using the @recipe.items association.

# The action loops through each item and checks whether it already belongs to a grocery list. If not, it creates a 
# new GroceryList and assigns it to the item using update_attribute. It then creates a new item on the grocery list 
# using the attributes of the original item.

# Finally, the action responds to the AJAX request with a JavaScript file that updates the grocery list table with 
# the new items using JavaScript DOM manipulation. The add_items.js.erb file would contain the JavaScript code that 
# updates the grocery list table.

  private
    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end
end
