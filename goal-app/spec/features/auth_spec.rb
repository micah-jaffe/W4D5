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
    User.create!(username: 'logger_in', password: 'password')
    
    visit new_session_url
    fill_in('Username:', with: 'logger_in')
    fill_in('Password:', with: 'password')
    click_button('Login')
    
    expect(page).to have_content('logger_in')
    expect(page).to have_current_path(user_url(User.find_by(username: 'logger_in')))
  end
  
  scenario 'responds appropriately to a failed login' do
    User.create!(username: 'logger_in', password: 'password')
    
    visit new_session_url
    fill_in('Username:', with: 'anything_else')
    fill_in('Password:', with: 'password')
    click_button('Login')
    
    expect(page).to have_content('Invalid credentials')
    expect(page).to have_current_path(new_session_url)
  end
  
  scenario 'cannot visit other user\'s pages if you are not logged in' do
    user = User.create!(username: 'private_page', password: 'password')
    visit user_url(user)
    
    expect(page).to have_current_path(new_session_url)
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit users_url
    expect(page).to_not have_content('Logout')
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    User.create!(username: 'logger_in', password: 'password')
    
    visit new_session_url
    fill_in('Username:', with: 'logger_in')
    fill_in('Password:', with: 'password')
    click_button('Login')
    
    click_button('Logout')
    expect(page).to_not have_content('logger_in')
    expect(page).to have_current_path(new_session_url)
    
  end
    
end