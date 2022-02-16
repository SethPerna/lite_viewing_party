require 'rails_helper'

RSpec.describe 'new user vew' do
  it 'has a form to register a new user' do
    visit register_path

    fill_in 'user_email', with: 'User@email.com'
    fill_in 'user_name', with: 'User Name'
    fill_in 'Password', with: '1234'
    fill_in 'Password confirmation', with: '1234'

    click_on 'Register'

    expect(current_path).to eq(user_path(User.first))
    expect(User.first.name).to eq('User Name')
  end
  it 'wont register an invalid user' do
    visit register_path

    fill_in 'user_email', with: ''
    fill_in 'user_name', with: ''

    click_on 'Register'
    within '.flash' do
      expect(page).to have_content('Invalid Entry')
    end
    within '.error-msgs' do
      expect(page).to have_content(/Name can't be blank Email can't be blank/)
    end
  end
  it 'wont register a user with non matching passwords ' do
    visit register_path

    fill_in 'user_email', with: 'User@email.com'
    fill_in 'user_name', with: 'User Name'
    fill_in 'Password', with: '1234'
    fill_in 'Password confirmation', with: '12345'

    click_on 'Register'
    within '.flash' do
      expect(page).to have_content('Invalid Entry')
    end
    
    within '.error-msgs' do
      expect(page).to have_content(/Password confirmation doesn't match Password/)
    end
  end
end
