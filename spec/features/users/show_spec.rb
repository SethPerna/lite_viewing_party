require 'rails_helper'
RSpec.describe 'users show page' do
  it 'has user name, button to discover movies & section that lists viewing parties' do
    user_1 = User.create!(name: 'user_1', email: 'email@gmail.com')
    user_2 = User.create!(name: 'user_2', email: 'test@gmail.com')
    user_3 = User.create!(name: 'user_3', email: 'test_2@gmail.com')
    party_1 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                            host: user_1.id, movie_id: 730_154)
    party_2 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Cloud Atlas',
                            host: user_2.id, movie_id: 83_542)
    user_1.parties << party_1
    user_1.parties << party_2
    user_2.parties << party_2

    VCR.use_cassette('users-show') do
      visit user_path(user_1)
      within '.name' do
        expect(page).to have_content(user_1.name)
      end
      within '.discover_movies' do
        expect(page).to have_button('Discover Movies')
      end
      within '.viewing-parties' do
        expect(page).to have_content(party_1.movie)
        expect(page).to have_content(party_1.movie)
      end
      within '.discover_movies' do
        click_button('Discover Movies')
        expect(current_path).to eq("/users/#{user_1.id}/discover")
      end
    end
  end
  it 'shows all the movie parties a user has been invited to' do
    user_1 = User.create!(name: 'user_1', email: 'email@gmail.com')
    user_2 = User.create!(name: 'user_2', email: 'test@gmail.com')
    user_3 = User.create!(name: 'user_3', email: 'test_2@gmail.com')
    party_1 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                            host: user_1.id, movie_id: 730_154)
    party_2 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Cloud Atlas',
                            host: user_2.id, movie_id: 83_542)
    user_1.parties << party_2
    user_2.parties << party_2
    user_3.parties << party_2
    VCR.use_cassette('user_invited_movies') do
      visit user_path(user_1)
      within '.invited' do
        expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/original/amNMifaMEd0FBOR289OcnRAJjTI.jpg']")
        expect(page).to have_link('Cloud Atlas')
        expect(page).to have_content("Date: #{party_2.date} Time: #{party_2.start_time}")
        expect(page).to have_content("Host: #{user_2.name}")
        expect(page).to have_content(user_1.name)
        expect(page).to have_content(user_3.name)
        expect(page).to have_content(user_2.name)
      end
    end
  end
end
