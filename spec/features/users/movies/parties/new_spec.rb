require 'rails_helper'
RSpec.describe 'new viewing party page' do
  it 'has title and form' do
    user_1 = User.create!(name: 'user', email: 'email')
    user_2 = User.create!(name: 'user 2', email: 'email_2')

    VCR.use_cassette('your_eyes_tell') do
      visit new_user_movie_party_path(user_1, "730154")
      within '.new-party-form' do
        expect(page).to have_content("Your Eyes Tell")
        expect(page).to have_selector("input[value='123']")
        fill_in "Duration", with: 130
        select "2022", :from => '_date_1i'
        select "February", :from => '_date_2i'
        select "6", :from => '_date_3i'
        select '7 PM', :from => '_time_4i'
        select '45', :from => '_time_5i'
        check("#{user_2.name}")
        expect(page).to have_button("Create Party")
        click_button("Create Party")
        expect(current_path).to eq()
      end
    end
  end
end
