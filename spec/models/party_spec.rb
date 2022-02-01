require 'rails_helper'
RSpec.describe Party, type: :model do
  describe 'validations' do
    it { should have_many(:user_parties) }
    it { should have_many(:users).through(:user_parties) }
  end
end
