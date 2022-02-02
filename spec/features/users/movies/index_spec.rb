require 'rails_helper'

RSpec.describe 'Users movies page' do
  it 'has top rated movies, movies are links to movie details page' do
    user = User.create!(name: 'user', email: 'email')

    VCR.use_cassette('top_rated_movies') do
      visit "/users/#{user.id}/discover"
      within '.discover-movies' do
        click_button 'Top Rated Movies'

        expect(current_path).to eq(user_movies_path(user))
      end
      within '.top-rated-movies' do
        expect(page.status_code).to eq(200)
        expect(page).to have_content('Your Eyes Tell | Vote Average: 8.8 ')
        expect(page).to have_content('The Lord of the Rings: The Return of the King | Vote Average: 8.5')
        expect(page).to have_link("Your Eyes Tell")
        click_link("Your Eyes Tell")
        expect(current_path).to eq("/users/#{user.id}/movies/730154")
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
        expect(page).to have_content('Fast & Furious Presents: Hobbs & Shaw | Vote Average: 6.9')
      end
    end
  end
end
