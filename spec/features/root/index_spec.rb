require 'rails_helper'

RSpec.describe 'landing page' do
  it 'has an application title' do
    user_1 = User.create!(name: 'user_1', email: 'email_1@gmail.com', password: '1234', password_confirmation: '1234')
    user_2 = User.create!(name: 'user_2', email: 'test@gmail.com', password: '1234', password_confirmation: '1234')
    user_3 = User.create!(name: 'user_3', email: 'test_2@gmail.com', password: '1234', password_confirmation: '1234')
    visit root_path
    within '.title' do
      expect(page).to have_content('Viewing Page Party')
    end


    visit root_path
    within '.new-user' do
      click_button 'Register'
      expect(current_path).to eq(register_path)
    end
  end

  it 'has link to login when clicked I am taken to login page' do
    user_1 = User.create!(name: 'user_1', email: 'email_9@gmail.com', password: '1234', password_confirmation: '1234')
    visit root_path
    within '.login' do
      expect(page).to have_button("Login")
      click_button("Login")
      expect(current_path).to eq("/login")
    end
  end
end
