class AddImageUrlColumntoRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :ImageURL, :text
  end
end
