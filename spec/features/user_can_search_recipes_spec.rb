require 'spec_helper'

describe 'User can search recipes' do

  it 'starts at basic search homepage' do
    visit root_path
    expect(page).to have_content 'Basic Recipe Search'
  end

  it "returns list of recipes matching search criteria" do
    visit root_path
    fill_in(:q, :with => "Bananas")
    click_on("Basic Recipe Search")
    expect(page).to have_content "Bananas"
  end

  it "can link to display recipe page from search results" do
    visit root_path
    fill_in(:q, :with => "Bananas")
    click_on("Basic Recipe Search")
    click_on("Raw Banana Ice Cream")
    expect(page).to have_content "270 minutes"
  end

  it "does not show option to save recipe to CookBook if logged out" do
    visit root_path
    fill_in(:q, :with => "Bananas")
    click_on("Basic Recipe Search")
    click_on("Raw Banana Ice Cream")
    expect(page).to_not have_content "Save to MyCookBook"
  end

  it "does show option to save recipe to CookBook if logged in" do
    visit root_path
    click_on("Sign up")
    fill_in("user_name", with: "mary")
    fill_in("user_email", with: "mary@mary.com")
    fill_in("user_password", with: "marymary")
    fill_in("user_password_confirmation", with: "marymary")
    click_on("Submit")
    visit root_path
    fill_in(:q, :with => "Bananas")
    click_on("Basic Recipe Search")
    click_on("Raw Banana Ice Cream")
    expect(page).should have_selector(:link_or_button, "create")
  end



end
