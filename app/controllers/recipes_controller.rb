class RecipesController < ApplicationController
  before_action(:get_json, only: [:search_result])
  before_action(:find_user, except: [:search_results])
  before_action(:new_recipe, only: [:search_result, :new, :create])
  before_action(:find_recipe, only: [:show, :edit, :update, :destroy])

  def search_results
    search_terms = params[:q].gsub(" ", "+")
    response_hash = HTTParty.get("http://api.bigoven.com/recipes?any_kw=#{search_terms}&pg=1&rpp=20&api_key=#{MY_API_KEY}")
    @search_results = response_hash["RecipeSearchResult"]["Results"]["RecipeInfo"]
  end

  def search_result
    @recipe = Recipe.new
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new
    #if creating a recipe via saving from search
    if params[:recipe_id] != nil
      get_json
      @recipe[:title] = @recipe_title
      @recipe[:imageURL] = @recipe_imageURL
      @recipe[:description] = @recipe_description
      @recipe[:cuisine] = @recipe_cuisine
      @recipe[:ingredients] = @recipe_ingredient_array
      @recipe[:instructions] = @recipe_instructions
      @recipe[:yield] = @recipe_yield
      @recipe[:time] = @recipe_time
      @recipe[:user_id] = params[:user_id]
      @recipe.save
      redirect_to user_recipes_path(@user)
    else #if creating a recipe via entering into form
      @recipe[:title] = params[:recipe][:title]
      @recipe[:imageURL] = params[:recipe][:imageURL]
      @recipe[:description] = params[:recipe][:description]
      @recipe[:cuisine] = params[:recipe][:cuisine]
      @recipe[:ingredients] = params[:recipe][:ingredients].split(",")
      @recipe[:instructions] = params[:recipe][:instructions].split(". ")
      @recipe[:yield] = params[:recipe][:yield]
      @recipe[:time] = params[:recipe][:time]
      @recipe[:user_id] = params[:user_id]
      @recipe.save
      redirect_to user_recipes_path(@user)
    end
  end

  def index
    @recipes = Recipe.where(user_id: @user.id)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to user_recipes_path
  end

  private

  def get_json
    @recipe_id = params[:recipe_id]
    response = HTTParty.get("http://api.bigoven.com/recipe/#{@recipe_id}?api_key=#{MY_API_KEY}")
    @recipe_imageURL = response["Recipe"]["ImageURL"]
    @recipe_title = response["Recipe"]["Title"]
    @recipe_description = response["Recipe"]["Description"]
    @recipe_cuisine = response["Recipe"]["Cuisine"]
    @recipe_yield = response["Recipe"]["YieldNumber"].to_s + " " + response["Recipe"]["YieldUnit"].to_s
    @recipe_time = response["Recipe"]["TotalMinutes"]
    @recipe_rating = response["Recipe"]["StarRating"].to_f.round(2)
    #WHY WILL THIS WORK IN PRY AND NOT IN MY APP :(
    @recipe_ingredient_array = response["Recipe"]["Ingredients"]["Ingredient"].map do |ingredient_hash|
      "#{ingredient_hash["Quantity"] } #{ingredient_hash["Unit"]} #{ingredient_hash["Name"]}"
    end
    @recipe_instructions = response["Recipe"]["Instructions"].split(". ")
  end

  def find_user
    @user = current_user
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def new_recipe
    @recipe = Recipe.new
  end

end
