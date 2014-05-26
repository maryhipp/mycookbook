require 'spec_helper'

describe 'User can see a homepage' do

  it 'has the title MyCookbook' do
    visit root_path
    expect(page).to have_content 'MyCookbook'
  end

end
