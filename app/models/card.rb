# Model Flash Cards
class Card < ApplicationRecord
  belongs_to :user
  validates :original_text, :translated_text, :review_date, presence: true
  validate :original_and_translated_text_not_equal

  after_initialize do
    self.review_date = 3.days.from_now if review_date.nil?
  end

  def original_and_translated_text_not_equal
    unless original_text.blank? || translated_text.blank?
      errors.add(:original_text, 'не должен совпадать с переведённым') if
        original_text.strip.mb_chars.downcase == translated_text.strip.mb_chars.downcase
    end
  end

  def check_translation?(user_text)
    user_text.strip.mb_chars.downcase == original_text.mb_chars.downcase
  end

  def change_review_date
    self.update(review_date: 3.days.from_now)
  end

  def self.user_cards(user_id)
    where(user_id: user_id)
  end

  scope :reviewed, -> { where('review_date <= ?', Time.now) }
  scope :random_cards, -> { order('random()') }
end
