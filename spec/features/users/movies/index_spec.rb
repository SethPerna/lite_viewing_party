require 'rails_helper'

RSpec.describe 'Discover Page' do
  it 'has a button to discover top rated movie' do
    user = User.create!(name: 'user', email: 'email')

    VCR.use_cassette('top_rated_movies') do
      visit "/users/#{user.id}/discover"
      within '.discover-movies' do
        click_button 'Top Rated Movies'

        expect(current_path).to eq(user_movies_path(user))
      end
      within '.top-rated-movies' do
        expect(page.status_code).to eq(200)
        expect(page).to have_content('Your Eyes Tell')
        expect(page).to have_content('The Lord of the Rings: The Return of the King')
      end
    end
  end

  it 'has a form to search for movies' do
    user = User.create!(name: 'user', email: 'email')

    VCR.use_cassette('search_movies') do
      visit "/users/#{user.id}/discover"
      within '.discover-movies' do
        fill_in 'search', with: 'Shaw'

        click_on 'Search'

        expect(current_path).to eq(user_movies_path(user))
      end

      within '.search-movie' do
        expect(page.status_code).to eq(200)
        expect(page).to have_content('Fast & Furious Presents: Hobbs & Shaw')
      end
    end
  end
end