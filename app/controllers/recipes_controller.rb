class RecipesController < ApplicationController
  before_action(:get_json, only: [:search_result, :create])

  def search_results
    search_terms = params[:q].gsub(" ", "+")
    response_hash = HTTParty.get("http://api.bigoven.com/recipes?any_kw=#{search_terms}&pg=1&rpp=20&api_key=dvx9275CydFfh2KPQzu33gsk1GEn7oyH")
    @search_results = response_hash["RecipeSearchResult"]["Results"]["RecipeInfo"]
  end

  def search_result
    @recipe = Recipe.new
    @user = current_user
  end

  def create
    @recipe = Recipe.new
    @recipe[:title] = @recipe_title
    @recipe[:description] = @recipe_description
    @recipe[:cuisine] = @recipe_cuisine
    @recipe[:category] = @recipe_category
    @recipe[:ingredients] = @recipe_ingredient_array
    @recipe[:instructions] = @recipe_instructions
    @recipe[:yield] = @recipe_yield
    @recipe[:time] = @recipe_time
    @recipe[:user_id] = params[:user_id]
    @recipe.save
    redirect_to user_recipes_path(current_user)
  end

  def index
    @user = current_user
    @recipes = Recipe.where(user_id: @user.id)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def get_json
    recipe_id = params[:recipe_id]
    response = HTTParty.get("http://api.bigoven.com/recipe/#{recipe_id}?api_key=dvx9275CydFfh2KPQzu33gsk1GEn7oyH")
    @recipe_imageURL = response["Recipe"]["ImageURL"]
    @recipe_title = response["Recipe"]["Title"]
    @recipe_description = response["Recipe"]["Description"]
    @recipe_cuisine = response["Recipe"]["Cuisine"]
    @recipe_category = response["Recipe"]["Category"]
    @recipe_yield = response["Recipe"]["YieldNumber"].to_s + " " + response["Recipe"]["YieldUnit"].to_s
    @recipe_time = response["Recipe"]["TotalMinutes"]
    @recipe_rating = response["Recipe"]["StarRating"].to_f.round(2)
    #WHY WILL THIS WORK IN PRY AND NOT IN MY APP :(
    @recipe_ingredient_array = response["Recipe"]["Ingredients"]["Ingredient"].map { |ingredient_hash| "#{ingredient_hash["Quantity"] } #{ingredient_hash["Unit"]} #{ingredient_hash["Name"]}" }
    @recipe_instructions = response["Recipe"]["Instructions"]
  end

end
