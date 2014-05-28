class GroceryListsController < ApplicationController
  def update
  end

  def destroy
  end

  def show
    @user = User.find(params[:user_id])
    @recipes = Recipe.where(grocery_list?: true)
  end



end
