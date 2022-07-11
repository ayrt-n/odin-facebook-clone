require 'rails_helper'

RSpec.describe 'Creating a user', type: :system do
  scenario 'with valid inputs' do
    visit new_user_registration_path

    fill_in 'Username', with: 'Testy McTester'
    fill_in 'Email', with: 'testman1@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
  
  scenario 'with invalid inputs' do
    visit new_user_registration_path

    fill_in 'Username', with: ''
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'p'
    fill_in 'Password confirmation', with: ''

    click_button 'Sign up'
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
    expect(page).to have_content("Username can't be blank")
  end
end