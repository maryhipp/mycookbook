require 'spec_helper'

describe 'User can save recipes from search' do

  it "does not show option to save recipe to CookBook if logged out" do
    visit root_path
    fill_in(:q, :with => "Bananas")
    click_on("Basic Recipe Search")
    click_on("Raw Banana Ice Cream")
    expect(page).to_not have_content "Save to MyCookBook"
  end

  context "when user is logged in" do
  before(:each) do
    visit root_path
    click_on("Sign up")
    fill_in("user_name", with: "mary")
    fill_in("user_email", with: "mary@mary.com")
    fill_in("user_password", with: "marymary")
    fill_in("user_password_confirmation", with: "marymary")
    click_on("Submit")
  end

    it "does show option to save recipe to CookBook if logged in" do
      visit root_path
      fill_in(:q, :with => "Bananas")
      click_on("Basic Recipe Search")
      click_on("Raw Banana Ice Cream")
      expect(page).should have_selector(:link_or_button, "create")
    end

    it "saves recipe to user's cookbook" do
      visit root_path
      fill_in(:q, :with => "Bananas")
      click_on("Basic Recipe Search")
      click_on("Raw Banana Ice Cream")
      click_on("Save Recipe to MyCookbook")
      expect(page).to have_content("Raw Banana Ice Cream")
    end

  end #--ends context user logged in
end

describe "user can input their own recipes to save" do
  context "when user is logged in" do
  before(:each) do
    visit root_path
    click_on("Sign up")
    fill_in("user_name", with: "mary")
    fill_in("user_email", with: "mary@mary.com")
    fill_in("user_password", with: "marymary")
    fill_in("user_password_confirmation", with: "marymary")
    click_on("Submit")
  end

  it "has the option on homepage of adding own recipe" do
    visit root_path
    expect(page).to have_content("Nah, I want to add my own")
  end

  it "links to form to fill in recipe details" do
    visit root_path
    click_on("Nah, I want to add my own")
    expect(page).to have_content("Create Your Own Recipe")
  end

  it "adds recipe to user's cookbook when form is submitted" do
    visit root_path
    click_on("Nah, I want to add my own")
    fill_in("recipe_title", with: "Rice Krispy Treats")
    click_on("Save Recipe to MyCookbook")
    expect(page).to have_content("Rice Krispy Treats")
  end
end
end
