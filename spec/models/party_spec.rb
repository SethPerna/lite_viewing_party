require 'rails_helper'
RSpec.describe Party, type: :model do
  describe 'validations' do
    it { should have_many(:user_parties) }
    it { should have_many(:users).through(:user_parties) }
  end

  describe '#find_host' do
    it 'finds a host for a party' do
      user_3 = User.create!(name: 'user_3', email: 'test_2@gmail.com', password: '1234', password_confirmation: '1234')
      user_2 = User.create!(name: 'user_3', email: 'test_3@gmail.com', password: '1234', password_confirmation: '1234')
      party_1 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                              host: user_3.id, movie_id: 730_154)
      user_3.parties << party_1
      user_2.parties << party_1
      actual = party_1.find_host
      expected = user_2.name
      expect(actual).to eq(expected)
    end
  end
end
