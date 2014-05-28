class GroceryListsController < ApplicationController
  def update
    @user = current_user
    if params['commit'] == 'Add to My Grocery List'
      @recipe = Recipe.find(params['recipe']['recipe_id'])
      @recipe[:grocery_list?] = true
      @recipe.save
    elsif params["commit"] == "Clear My Grocery List"

      @recipes = Recipe.where(grocery_list?: true)
      @recipes.each do |recipe|
        recipe[:grocery_list?] = false
        recipe.save
      end

    end
    redirect_to user_grocery_list_path(current_user)
  end

  def show
    @user = current_user
    @recipes = Recipe.where(grocery_list?: true)
    @grocery_list_array = []
    @recipes.each do |recipe|
      @grocery_list_array.concat(recipe[:ingredients])
    end

  end



end
