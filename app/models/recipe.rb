class Recipe < ActiveRecord::Base
  belongs_to :user
  serialize :ingredients, Array
  serialize :instructions, Array
end
