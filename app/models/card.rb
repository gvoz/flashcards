class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :original_and_translated_text_not_equal

  after_initialize do
    self.review_date = 3.days.from_now if review_date.nil?
  end

  def original_and_translated_text_not_equal
    unless original_text.blank? || translated_text.blank?
      errors.add(:original_text, 'не должен совпадать с переведённым') if
        original_text.mb_chars.downcase == translated_text.mb_chars.downcase
    end
  end

  def self.check_translate(id, user_text)
    @card = Card.find(id)
    if user_text.mb_chars.downcase == @card.original_text.mb_chars.downcase
      @card.review_date = 3.days.from_now
      @card.save
      return true
    else
      return false
    end
  end

  scope :reviewed, -> { where('review_date <= ?', Time.now) }
  scope :random_cards, -> { order('random()') }
end
