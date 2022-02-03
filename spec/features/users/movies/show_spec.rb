require 'rails_helper'

RSpec.describe 'Users movie show page' do
  it 'has buttons to create viewing party and to return to discovery page' do
    user = User.create!(name: 'user', email: 'email')

    visit "/users/#{user.id}/movies/730154"
    within '.buttons' do
      expect(page).to have_button("Create Viewing Party")
      expect(page).to have_button("Discover Page")
      click_button("Discover Page")
      expect(current_path).to eq("/users/#{user.id}/discover")
    end
  end

  it 'has movie title, average, runtime, genre(s), summary' do
    user = User.create!(name: 'user', email: 'email')

    VCR.use_cassette('your_eyes_tell') do
      visit "/users/#{user.id}/movies/730154"
      within '.movie-info' do
        expect(page).to have_content("Title: Your Eyes Tell")
        expect(page).to have_content("Vote Average: 8.8")
        expect(page).to have_content("Runtime: 2 hours 3 minutes")
        expect(page).to have_content("Genre(s): Romance Drama")
        expect(page).to have_content("Summary: A tragic accident")
      end
    end
  end
  it 'review count & author info' do
    user = User.create!(name: 'user', email: 'email')

    VCR.use_cassette('your_eyes_tell_reviews') do
      visit "/users/#{user.id}/movies/730154"
      within '.movie-info' do
        expect(page).to have_content("Total Reviews: 25")
        expect(page).to have_content("Author: Fuckface")
      end
    end
  end
end
