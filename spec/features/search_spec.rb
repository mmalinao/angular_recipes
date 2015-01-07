require 'rails_helper'

feature 'Looking up recipes', :js do
  scenario 'finding recipes' do
    visit '/'
    fill_in 'keywords', with: 'baked'
    click_on 'Search'

    expect(page).to have_content('Baked Potato')
    expect(page).to have_content('Baked Brussel Sprouts')
  end
end
