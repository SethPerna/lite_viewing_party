require 'rails_helper'

RSpec.describe 'Discover Page' do
  it 'has a button to discover top rated movie' do
    user = User.create!(name: 'user', email: 'email')

    VCR.use_cassette('top_rated_movies') do
      visit "/users/#{user.id}/discover"
      within '.top-rated-movies' do
        click_button 'Top Rated Movies'
        save_and_open_page
        expect(page.status_code).to eq(200)
        expect(page).to have_content('Your Eyes Tell')
      end
    end
  end
end
