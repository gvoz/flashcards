# Model User
class User < ApplicationRecord
  # attr_accessible :email, :password, :password_confirmation, :authentications_attributes
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  has_many :decks, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: :password
  validates :password, confirmation: true, if: :password
  validates :password_confirmation, presence: true, if: :password

  validates :email, uniqueness: true
end
