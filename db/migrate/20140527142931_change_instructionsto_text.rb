class ChangeInstructionstoText < ActiveRecord::Migration
  def change
    change_column :recipes, :instructions, :text
    change_column :recipes, :ingredients, :text
  end
end
