require 'rails_helper'

RSpec.describe 'Discover Page' do
  it 'has a button to discover top rated movies' do
    user = User.create!(name: 'user', email: 'email', password: '1234', password_confirmation: '1234')

    VCR.use_cassette('top_rated_movies') do
      visit "/users/#{user.id}/discover"
      within '.discover-movies' do
        click_button 'Top Rated Movies'

        expect(current_path).to eq(user_movies_path(user))
      end
    end
  end
  it 'has a button to discover top rated movies' do
    user = User.create!(name: 'user', email: 'email', password: '1234', password_confirmation: '1234')
    VCR.use_cassette('search_movies') do
      visit "/users/#{user.id}/discover"
      within '.discover-movies' do
        fill_in 'search', with: 'Shaw'
        click_on 'Search'

        expect(current_path).to eq(user_movies_path(user))
      end
    end
  end
end
