require 'rails_helper'
RSpec.describe 'users show page' do
  it 'has user name, button to discover movies & section that lists viewing parties' do
    user_1 = User.create!(name: 'user_1', email: 'email@gmail.com')
    user_2 = User.create!(name: 'user_2', email: 'test@gmail.com')
    user_3 = User.create!(name: 'user_3', email: 'test_2@gmail.com')
    visit user_path(user_1)
    within '.name' do
      expect(page).to have_content(user_1.name)
    end
    within '.discover_movies' do
      expect(page).to have_button("Discover Movies")
    end
    within '.viewing_parties' do
      expect(page).to have_content()
    end
  end
end
