class Quality

  def self.check_translate(card, user_text)
    distance = DamerauLevenshtein.distance(user_text.strip.mb_chars.downcase, card.original_text.mb_chars.downcase)
    SuperMemo.change_interval(card, distance)
    new(distance)
  end

  def initialize(distance)
    if distance.zero?
      @quality = 'success'
    elsif distance < 3
      @quality = 'misprint'
    else
      @quality = 'error'
    end
  end

  def success?
    @quality == 'success'
  end

  def misprint?
    @quality == 'misprint'
  end

  def error?
    @quality == 'error'
  end

end
