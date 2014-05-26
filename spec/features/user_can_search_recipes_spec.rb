require 'spec_helper'

describe 'User can search recipes' do
  it 'starts at basic search homepage' do
    visit root_path
    expect(page).to have_content 'Basic Recipe Search'
  end

  it 'can choose to see advanced search page' do
    visit root_path
    click_link('Advanced Search')
    expect(page).to have_content 'Advanced Recipe Search'
  end

  it 'can return to basic search' do
    visit root_path
    click_link('Advanced Search')
    click_link('Basic Search')
    expect(page).to have_content 'Basic Search'
  end
end
