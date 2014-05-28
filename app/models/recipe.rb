class Recipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :grocery_list
  serialize :ingredients, Array
  serialize :instructions, Array

  validates :title,
    presence: true


end
