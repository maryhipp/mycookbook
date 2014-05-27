class EditTitleofImageUrlColumn < ActiveRecord::Migration
  def change
    rename_column :recipes, :ImageURL, :imageURL
  end
end
