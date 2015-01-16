require 'rails_helper'

feature "Creating a recipe", :js do
  scenario 'create a new recipe' do
    visit '/'
    click_on 'New Recipe'

    fill_in 'name', with: 'Baked Brussel Sprouts'
    fill_in 'instructions', with: 'Slather in oil, then bake for 20 mins'

    click_on 'Save'

    expect(page).to have_content('Baked Brussel Sprouts')
    expect(page).to have_content('Slather in oil')

    expect(Recipe.find_by_name('Baked Brussel Sprouts')).to_not be_nil
  end
end
