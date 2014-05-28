require 'spec_helper'

describe 'User cannot save recipes from search if logged out' do

  it "does not show option to save recipe to CookBook if logged out" do
    visit root_path
    fill_in(:q, :with => "Bananas")
    click_on("Basic Recipe Search")
    click_on("Raw Banana Ice Cream")
    expect(page).to_not have_content "Save to MyCookBook"
  end
end

describe 'User can save recipes from search if logged in' do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    login(user)
    visit root_path
    fill_in(:q, :with => "Bananas")
    click_on("Basic Recipe Search")
    click_on("Raw Banana Ice Cream")
  end

    it "does show option to save recipe to CookBook if logged in" do
      expect(page).should have_selector(:link_or_button, "create")
    end

    it "saves recipe to user's cookbook" do
      click_on("Save Recipe to MyCookbook")
      expect(page).to have_content("Raw Banana Ice Cream")
    end

  def login(user)
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end


end

describe "user can input their own recipes to save" do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) { login(user) }

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

  def login(user)
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end

end
