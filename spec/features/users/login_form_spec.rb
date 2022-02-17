require 'rails_helper'
RSpec.describe 'login page' do
  it 'has fields to login when correctly submitted I am take to my show page' do
    user_1 = User.create!(name: 'user_1', email: 'gseth@gmail.com', password: '1234', password_confirmation: '1234')
    visit "/login"
    fill_in "Email", with: "#{user_1.email}"
    fill_in "Password", with: "#{user_1.password}"
    click_button("Login")
    expect(current_path).to eq("/users/#{user_1.id}")
  end

  it 'has fields to login when correctly submitted I am take to my show page' do
    user_1 = User.create!(name: 'user_1', email: 'gseth@gmail.com', password: '1234', password_confirmation: '1234')
    visit "/login"
    fill_in "Email", with: "#{user_1.email}"
    fill_in "Password", with: "lkaihsdfjkahf"
    click_button("Login")
    expect(current_path).to eq("/login")
    within '.flash' do
      expect(page).to have_content('Invalid email/password')
    end
  end
end
