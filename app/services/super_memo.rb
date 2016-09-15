# SuperMemo algorithm https://www.supermemo.com/english/ol/sm2.htm
class SuperMemo

  def self.change_interval(card, distance)
    quality = get_quality(distance)
    efactor = quality > 2 ? get_efactor(quality, card.efactor) : card.efactor
    repeat = get_repeat(quality, card.repeat)
    interval = get_interval(repeat, card.review_interval, efactor)
    card.change_review_date(repeat, efactor, interval)
  end

  def self.get_quality(distance)
    if distance.zero?
      5
    else
      5 - distance
    end
  end

  def self.get_efactor(quality, efactor)
    efactor = efactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    efactor > 1.3 ? efactor : 1.3
  end

  def self.get_repeat(quality, repeat)
    if quality < 3
      1
    else
      repeat + 1
    end
  end

  def self.get_interval(repeat, interval, efactor)
    if repeat < 2
      1
    elsif repeat == 2
      6
    else
      efactor * interval
    end
  end
end
