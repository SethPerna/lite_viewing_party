require 'rails_helper'
RSpec.describe 'new viewing party page' do
  before :each do
    @user_1 = User.create!(name: 'user', email: 'email', password: '1234', password_confirmation: '1234')
    visit '/login'
    fill_in :email, with: 'ChuckNorris@ChuckNorris.com'
    fill_in :password, with: 'LFG'
  end
  it 'has title and form' do

    user_2 = User.create!(name: 'user 2', email: 'email_2', password: '1234', password_confirmation: '1234')

    VCR.use_cassette('your_eyes_tell_new') do
      visit new_user_movie_party_path(@user_1, '730154')
      within '.new-party-form' do
        expect(page).to have_content('Your Eyes Tell')
        fill_in 'Duration', with: 130
        select '2022', from: '_date_1i'
        select 'February', from: '_date_2i'
        select '6', from: '_date_3i'
        select '7 PM', from: '_time_4i'
        select '45', from: '_time_5i'
        check("invites_#{user_2.id}")
        expect(page).to have_button('Create Party')
        click_button('Create Party')
        expect(current_path).to eq(dashboard_path)
      end
    end
  end
  it 'wont let duration of the party be shorter than runtime of the movie', :vcr do
    user_1 = User.create!(name: 'user', email: 'email', password: '1234', password_confirmation: '1234')
    user_2 = User.create!(name: 'user 2', email: 'email_2', password: '1234', password_confirmation: '1234')

    visit new_user_movie_party_path(user_1, '730154')
    within '.new-party-form' do
      fill_in 'Duration', with: 122
      select '2022', from: '_date_1i'
      select 'February', from: '_date_2i'
      select '6', from: '_date_3i'
      select '7 PM', from: '_time_4i'
      select '45', from: '_time_5i'
      check("invites_#{user_2.id}")

      click_button('Create Party')
    end
    within '.flash' do
      expect(page).to have_content(/Duration can't be shorter than movies runtime./)
      expect(current_path).to eq(new_user_movie_party_path(user_1, '730154'))
    end
  end


  it 'invites users to the party that are checked off in form', :vcr do
    user_1 = User.create!(name: 'user', email: 'email', password: '1234', password_confirmation: '1234')
    user_2 = User.create!(name: 'user 2', email: 'email_2', password: '1234', password_confirmation: '1234')
    user_3 = User.create!(name: 'user 3', email: 'email_3', password: '1234', password_confirmation: '1234')
    user_4 = User.create!(name: 'user 4', email: 'email_4', password: '1234', password_confirmation: '1234')
    visit new_user_movie_party_path(user_1, '730154')
    within '.new-party-form' do
      fill_in 'Duration', with: 145
      select '2022', from: '_date_1i'
      select 'February', from: '_date_2i'
      select '6', from: '_date_3i'
      select '7 PM', from: '_time_4i'
      select '45', from: '_time_5i'
      check("invites_#{user_2.id}")
    end
  end

  it 'invites users to the party that are checked off in form' do
    VCR.use_cassette('new_movie_cassette') do
      user_1 = User.create!(name: 'user', email: 'email_9', password: '1234', password_confirmation: '1234')
      user_2 = User.create!(name: 'user 2', email: 'email_8', password: '1234', password_confirmation: '1234')
      user_3 = User.create!(name: 'user 3', email: 'email_7', password: '1234', password_confirmation: '1234')
      user_4 = User.create!(name: 'user 4', email: 'email_6', password: '1234', password_confirmation: '1234')
      visit new_user_movie_party_path(user_1, '730154')
      within '.new-party-form' do
        fill_in 'Duration', with: 145
        select '2022', from: '_date_1i'
        select 'February', from: '_date_2i'
        select '6', from: '_date_3i'
        select '7 PM', from: '_time_4i'
        select '45', from: '_time_5i'
        check("invites_#{user_2.id}")


        check("invites_#{user_3.id}")
        click_button 'Create Party'
        expect(current_path).to eq(user_path(user_1))
      end
      visit user_path(user_2)
      within '.invited' do
        expect(page).to have_content('Movie: Your Eyes Tell')
      end
    end
  end
end
