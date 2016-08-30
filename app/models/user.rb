# Model Users
class User < ApplicationRecord
  has_many :cards, dependent: :destroy

  validates :login, :email, :password, presence: true
end
