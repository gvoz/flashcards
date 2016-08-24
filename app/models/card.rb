class Card < ApplicationRecord
  validates :original_text, presence: { message: 'должен быть указан оригинальный текст' }
  validates :translated_text, presence: { message: 'должен быть указан переведённый текст' }
  validates :review_date, presence: { message: 'должна быть указана дата пересмотра карточки' }
  validate :original_and_translated_text_not_equal

  after_initialize do
    self.review_date = Date.today.next_day(3) if review_date.nil?
  end

  def original_and_translated_text_not_equal
    unless original_text.blank? || translated_text.blank?
      errors.add(:original_text, 'не должен совпадать с переведённым') if
        original_text.mb_chars.downcase == translated_text.mb_chars.downcase
    end
  end
end
