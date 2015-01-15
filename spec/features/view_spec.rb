require 'rails_helper'

feature 'Viewing a recipe', :js do
  before(:each) do
    FactoryGirl.create(:recipe, name: 'Baked Potato w/ Cheese', instructions: 'nuke for 20 mins')
    FactoryGirl.create(:recipe, name: 'Baked Brussel Sprouts', instructions: 'Slather in oil, and on high heat for 20 mins')
  end

  scenario 'view one recipe' do
    visit '/'
    fill_in 'keywords', with: 'baked'
    click_on 'Search'

    click_on 'Baked Brussel Sprouts'

    expect(page).to have_content('Baked Brussel Sprouts')
    expect(page).to have_content('Slather in oil')

    click_on 'Back'

    expect(page).to have_content('Baked Brussel Sprouts')
    expect(page).to_not have_content('Slather in oil')
  end
end
