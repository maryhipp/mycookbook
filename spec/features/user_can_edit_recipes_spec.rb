require 'spec_helper'

describe 'User can edit recipes in their Cookbook' do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    login(user)
    visit root_path
    fill_in(:q, :with => "Bananas")
    click_on("Basic Recipe Search")
    click_on("Raw Banana Ice Cream")
    click_on("Save Recipe to MyCookbook")
    click_on("Raw Banana Ice Cream")
    click_on("Edit Recipe")
  end

    it "can link to edit page from recipe page" do
      expect(page).to have_content("Edit Raw Banana Ice Cream")
    end

    it "can edit a field on edit page to persist in database" do
      fill_in("recipe_title", with: "Banana Fro-yo")
      click_on("Save Recipe to MyCookbook")
      expect(page).to have_content("Banana Fro-yo")
    end

  def login(user)
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end #--ends context logged in

