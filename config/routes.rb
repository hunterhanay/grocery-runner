Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "recipes#index"

  resources :recipes do
    resources :items
    post 'add_items', on: :member
  end
  resources :grocery_list_items do 
    collection do
      delete :destroy_all
    end
  end

end
# This code adds a new member route to the recipes resource that responds to a POST request and maps to the add_items 
# action in the RecipesController. The on: :member option tells Rails to generate a URL that includes the ID of the 
# recipe being added. With this modification, you can use the button or link in your view to trigger the add_items action.