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
        original_text.strip.mb_chars.downcase == translated_text.strip.mb_chars.downcase
    end
  end

  def check_translation?(user_text)
    user_text.strip.mb_chars.downcase == original_text.mb_chars.downcase
  end

  def increase_review_interval
    if review_interval == 0
      update_columns(review_interval: 0.5)
    elsif review_interval == 0.5
      update_columns(review_interval: 3)
    elsif review_interval != 31
      update_columns(review_interval: 2 * review_interval + 1)
    end
    change_review_date(review_interval)
  end

  def decrease_review_interval
    if review_interval == 3
      update_columns(review_interval: 0.5)
    elsif review_interval == 0.5
      update_columns(review_interval: 0)
    elsif review_interval != 0
      update_columns(review_interval: (review_interval - 1)/2 )
    end
    change_review_date(review_interval)
  end

  def correct_translation
    update_columns(number_of_mistakes: 0)
    increase_review_interval
  end

  def incorrect_translation
    if number_of_mistakes == 3
      update_columns(number_of_mistakes: 0)
      decrease_review_interval
    else
      update_columns(number_of_mistakes: number_of_mistakes + 1)
    end
  end

  def change_review_date(review_interval = 3)
    update_columns(review_date: review_interval.days.from_now)
  end

  scope :reviewed, -> { where('review_date <= ?', Time.now) }
  scope :random_cards, -> { order('random()') }
end
