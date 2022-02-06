require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships / validations' do
    it { should have_many(:user_parties) }
    it { should have_many(:parties).through(:user_parties) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
  end
  describe '#invites' do
    it 'lists parties this person has been invited to!' do
      user = User.create!(name: 'Bill', email: 'Willy@hotmail.com')
      user_2 = User.create!(name: 'Bill', email: 'Willy@hotmail.com')
      party_1 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                              host: user.id, movie_id: 730_154)
      party_2 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                              host: user_2.id, movie_id: 730_154)
      user.user_parties.create!(party_id: party_1.id, user_id: user.id)
      user.user_parties.create!(party_id: party_2.id, user_id: user.id)
      actual = user.invites
      expected = [party_2]
    end
  end
  describe '#hosting' do
    it 'lists parties this person has been invited to!' do
      user = User.create!(name: 'Bill', email: 'Willy@hotmail.com')
      user_2 = User.create!(name: 'Bill', email: 'Willy@hotmail.com')
      party_1 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                              host: user.id, movie_id: 730_154)
      party_2 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                              host: user_2.id, movie_id: 730_154)
      party_3 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                              host: user.id, movie_id: 730_154)
      user.user_parties.create!(party_id: party_1.id, user_id: user.id)
      user.user_parties.create!(party_id: party_2.id, user_id: user.id)
      user.parties << party_3
      actual = user.invites
      expected = [party_1, party_3]
    end
  end
end
