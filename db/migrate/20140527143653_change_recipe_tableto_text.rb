class ChangeRecipeTabletoText < ActiveRecord::Migration
  def change
    change_column :recipes, :title, :text
    change_column :recipes, :description, :text
  end
end
