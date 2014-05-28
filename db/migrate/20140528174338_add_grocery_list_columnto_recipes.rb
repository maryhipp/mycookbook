class AddGroceryListColumntoRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :grocery_list?, :boolean
  end
end
