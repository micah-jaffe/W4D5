require 'rails_helper'
require 'spec_helper'

feature 'signing up' do
  
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content('Create User')
  end
  
  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      visit new_user_url
      fill_in('Username:', with: 'pass_specs')
      fill_in('Password:', with: 'password')
      click_button('Signup')
      
      expect(page).to have_content('pass_specs')
      expect(page).to have_current_path(user_url(User.find_by(username: 'pass_specs')))
    end
  end
  
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    user = User.create!(username: 'pass_specs', password: 'password')
    visit user_url(user)
    expect(page).to have_content("pass_specs")
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    
  end

  scenario 'doesn\'t show username on the homepage after logout'

end