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

end
