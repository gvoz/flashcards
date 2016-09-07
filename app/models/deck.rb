# model Deck of Flash Cards
class Deck < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :cards, dependent: :destroy

  before_save do
    if current
      @deck = Deck.user_decks(user_id).current
      @deck.update(current: false)
    end
  end

  def self.user_decks(user_id)
    where(user_id: user_id)
  end

  scope :current, -> { where(current: true) }
end
