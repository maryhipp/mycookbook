class AddDefaulttoGroceryListColumn < ActiveRecord::Migration
  def up
    change_column :recipes, :grocery_list?, :boolean, :default => false
  end

  def down
    change_column :recipes, :grocery_list?, :boolean, :default => nil
  end
end
