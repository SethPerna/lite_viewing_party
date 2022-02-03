require 'rails_helper'

RSpec.describe 'Users movie show page' do
  it 'has buttons to create viewing party and to return to discovery page' do
    user = User.create!(name: 'user', email: 'email')
    VCR.use_cassette('your_eyes_tell') do
      visit "/users/#{user.id}/movies/730154"
      within '.buttons' do
        expect(page).to have_button("Create Viewing Party")
        expect(page).to have_button("Discover Page")
        click_button("Discover Page")
        expect(current_path).to eq("/users/#{user.id}/discover")
      end
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

    VCR.use_cassette('cloud_atlas_reviews') do
      visit "/users/#{user.id}/movies/83542"
      within '.movie-info' do
        expect(page).to have_content("Total Reviews: 3")
        expect(page).to have_content("Author: tanty")
        expect(page).to have_content("Review: Interesting film with")
      end
    end
  end

  it 'lists the first ten cast members' do
    user = User.create!(name: 'user', email: 'email')

    VCR.use_cassette('cloud_atlas_cast') do
      visit "/users/#{user.id}/movies/83542"
      within '.movie-info' do
        expect(page).to have_content("Tom Hanks as Dr. Henry Goose")
      end
    end
  end
end
