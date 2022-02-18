require 'rails_helper'

RSpec.describe 'Discover Page' do
  before :each do
    @user_1 = User.create!(name: 'user_1', email: 'email@gmail.com', password: '1234', password_confirmation: '1234')
    visit "/login"
    fill_in "Email", with: "#{@user_1.email}"
    fill_in "Password", with: "#{@user_1.password}"
    click_button("Login")
    expect(current_path).to eq("/dashboard")
  end
  it 'has a button to discover top rated movies' do

    VCR.use_cassette('top_rated_movies') do
      visit "dashboard/discover"
      within '.discover-movies' do
        click_button 'Top Rated Movies'

        expect(current_path).to eq(dashboard_movies_path)
      end
    end
  end

  it 'has a button to discover top rated movies' do
    user = User.create!(name: 'user', email: 'email', password: '1234', password_confirmation: '1234')
    VCR.use_cassette('search_movies') do
      visit "/dashboard/discover"
      within '.discover-movies' do
        fill_in 'search', with: 'Shaw'
        click_on 'Search'

        expect(current_path).to eq(dashboard_movies_path)
      end
    end
  end
end
