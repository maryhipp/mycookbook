class CreateRecipe < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :description
      t.string :cuisine
      t.string :category
      t.string :ingredients
      t.string :instructions
      t.string :yield
      t.integer :time
      t.references :user
    end
  end
end
