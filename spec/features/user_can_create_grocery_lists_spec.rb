require 'spec_helper'

describe 'User can add saved recipes to grocery list' do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    login(user)
    visit root_path
    fill_in(:q, :with => "Bananas")
    click_on("Basic Recipe Search")
    click_on("Raw Banana Ice Cream")
    click_on("Save Recipe to MyCookbook")
    click_on("Raw Banana Ice Cream")
  end

  it 'presents option on recipe page in cookbook to add to current grocery list' do
    expect(page).to have_selector(:link_or_button, "Add to My Grocery List")
  end

  it 'allows user to see grocery list' do
    click_on("My Grocery List")
    expect(page).to have_content("#{user.name}'s Grocery List")
  end

  it 'adds ingredients from that recipe to grocery list' do
    click_on("Add to My Grocery List")
    click_on("My Grocery List")
    expect(page).to have_content("Raw Banana Ice Cream")
  end





  def login(user)
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end

end
