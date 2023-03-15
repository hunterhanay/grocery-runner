class RecipesController < ApplicationController
  #  before_action :set_items, only: [:index]
  
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
    
# In this example, we first find the recipe based on the params[:id] parameter sent by the 
# AJAX request. We then use the map method to iterate through each item in the recipe and
# create a hash of the item's attributes that we want to copy to the grocery list item. 
# We also merge the recipe_id attribute to ensure that the grocery list items are associated 
# with the correct recipe.

# Once we have an array of grocery list item attributes, we use the create method to create 
# all the grocery list items in a single step. Finally, we respond to the AJAX request with 
# a JavaScript file that updates the grocery list table with the new items using JavaScript 
# DOM manipulation.

# Note that in order for this to work, you will need to ensure that the GroceryListItem 
# model has all the necessary attributes (i.e. name, description, amount_type, amount, 
#   price, grocery_type, and recipe_id).
    # @grocery_list_items = @recipe.items.map do |item|
    #   item.attributes.slice("name", "description", "amount_type", "amount", "price", "grocery_type").merge(recipe_id: @recipe.id)
    # end
    # GroceryListItem.create(@grocery_list_items)
    # if i wanted to interate over each item in the recipe
    @items = @recipe.items
    @items.each do |item|
      grocery_list_item = GroceryListItem.new(
        name: item.name,
        description: item.description,
        amount_type: item.amount_type,
        amount: item.amount,
        price: item.price,
        grocery_type: item.grocery_type
      )
      grocery_list_item.save
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

  # private
  #   def set_items
  #     @items = Item.all # Set @items to all items in the database
  #   end
end
