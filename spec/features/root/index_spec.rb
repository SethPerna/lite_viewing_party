require 'rails_helper'

RSpec.describe 'landing page' do
  it 'has an application title' do
    user_1 = User.create!(name: 'user_1', email: 'email@gmail.com')
    user_2 = User.create!(name: 'user_2', email: 'test@gmail.com')
    user_3 = User.create!(name: 'user_3', email: 'test_2@gmail.com')
    visit root_path
    within '.title' do
      expect(page).to have_content('Viewing Page Party')
    end

    within '.all-users' do
      expect(page).to have_link(user_1.name)
      expect(page).to have_link(user_2.name)
      expect(page).to have_link(user_3.name)

      click_link(user_1.name)

      expect(current_path).to eq(user_path(user_1))
    end

    visit root_path
    within '.new-user' do
      click_button 'Register'
      expect(current_path).to eq(register_path)
    end
  end
end
