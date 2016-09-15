# Model Flash Cards
class Card < ApplicationRecord
  belongs_to :deck
  belongs_to :user
  mount_uploader :image, CardUploader
  validates :original_text, :translated_text, :review_date, presence: true
  validate :original_and_translated_text_not_equal

  after_initialize do
    self.review_date = Time.current if review_date.nil?
  end

  def original_and_translated_text_not_equal
    unless original_text.blank? || translated_text.blank?
      errors.add(:original_text, 'не должен совпадать с переведённым') if
        comparing_strings(original_text, translated_text)
    end
  end

  def change_review_date(repeat, efactor, interval)
    update_columns(
      review_date: interval.days.from_now,
      review_interval: interval,
      repeat: repeat,
      efactor: efactor)
  end

  def comparing_strings(str1, str2)
    str1.strip.mb_chars.casecmp(str2.strip.mb_chars.downcase).zero?
  end

  scope :reviewed, -> { where('review_date <= ?', Time.now) }
  scope :random_cards, -> { order('random()') }
end
