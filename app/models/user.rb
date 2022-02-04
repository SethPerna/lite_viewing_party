class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates_presence_of :name, :email
end
