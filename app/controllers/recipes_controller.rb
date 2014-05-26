class RecipesController < ApplicationController

  def search_results
    search_terms = params[:q].gsub(" ", "+")
    response_hash = HTTParty.get("http://api.bigoven.com/recipes?any_kw=#{search_terms}&pg=1&rpp=20&api_key=dvx9275CydFfh2KPQzu33gsk1GEn7oyH")
    @search_results = response_hash["RecipeSearchResult"]["Results"]["RecipeInfo"]
  end

  def search_result
    @recipe_id = params[:recipe_id]
    @response = HTTParty.get("http://api.bigoven.com/recipe/#{@recipe_id}?api_key=dvx9275CydFfh2KPQzu33gsk1GEn7oyH")
    @recipe_imageURL = @response["Recipe"]["ImageURL"]
    @recipe_title = @response["Recipe"]["Title"]
    @recipe_description = @response["Recipe"]["Description"]
    @recipe_cuisine = @response["Recipe"]["Cuisine"]
    @recipe_category = @response["Recipe"]["Category"]
    @recipe_yield = @response["Recipe"]["YieldNumber"] + " " + @response["Recipe"]["YieldUnit"]
    @recipe_time = @response["Recipe"]["TotalMinutes"]
    @recipe_rating = @response["Recipe"]["StarRating"].to_f.round(2)
    @recipe_ingredient_array = @response["Recipe"]["Ingredients"]["Ingredient"].map do |ingredient_hash|
        ingredient_hash["Quantity"] + " " + ingredient_hash["Unit"] + " " + ingredient_hash["Name"]
    end
    @recipe_instructions = @response["Recipe"]["Instructions"]

  end

  def create
    @recipe = Recipe.new(
      title: @recipe_title,
      description: @recipe_description,
      cuisine: @recipe_cuisine,
      category: @recipe_category,
      ingredients: @recipe_ingredient_array,
      instructions: @recipe_instructions,
      yield: @recipe_yield,
      time: @recipe_time,
      user_id: params[:user_id]
      )
  end

  private

  def recipe_params
    params.require(:recipe).permite()
  end

end
