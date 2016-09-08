# model Deck of Flash Cards
class Deck < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :cards, dependent: :destroy

  def make_current
    user.decks.update_all(current: false)
    update_columns(current: true)
  end

  scope :current, -> { where(current: true) }
  scope :order_current, -> { order('current desc') }
end
