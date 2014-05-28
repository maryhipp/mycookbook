class GroceryList < ActiveRecord::Base
  has_many :recipes
  belongs_to :user
end
