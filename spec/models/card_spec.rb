require "rails_helper"

describe Card do
  let!(:user) { create :user }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, user: user, deck: deck) }

  context "check translation" do
    it "wrong translation" do
      expect(card.check_translation?("battlestart")).to be false
    end

    it "correct translation" do
      expect(card.check_translation?("hause")).to be true
    end

    it "case-sensitive translation" do
      expect(card.check_translation?("HauSe")).to be true
    end

    it "extra spaces translation" do
      expect(card.check_translation?("   hause    ")).to be true
    end
  end

  it "change review date" do
    card.change_review_date(5)
    expect(card.review_date.strftime("%d/%m/%Y")).to eq 5.days.from_now.strftime("%d/%m/%Y")
  end

  context "correct translation" do
    it "reset number of mistakes" do
      card.correct_translation
      expect(card.number_of_mistakes).to eq 0
    end

    it "from 0 to 0.5" do
      card.review_interval = 0
      card.correct_translation
      expect(card.review_interval).to eq 0.5
    end

    it "from 0 to 0.5" do
      card.review_interval = 0.5
      card.correct_translation
      expect(card.review_interval).to eq 3
    end

    it "by formula 2x+1" do
      card.correct_translation
      expect(card.review_interval).to eq 15
    end

    it "not more 31 days" do
      card.review_interval = 31
      card.correct_translation
      expect(card.review_interval).to eq 31
    end
  end

  context "incorrect translation" do
    it "up number of mistakes" do
      card.number_of_mistakes = 2
      card.incorrect_translation
      expect(card.number_of_mistakes).to eq 3
    end

    it "not less 0 days" do
      card.review_interval = 0
      card.incorrect_translation
      expect(card.review_interval).to eq 0
    end

    it "from 0.5 to 0" do
      card.review_interval = 0.5
      card.incorrect_translation
      expect(card.review_interval).to eq 0
    end

    it "from 3 to 0.5" do
      card.review_interval = 3
      card.incorrect_translation
      expect(card.review_interval).to eq 0.5
    end

    it "by formula (x-1)/2" do
      card.incorrect_translation
      expect(card.review_interval).to eq 3
    end
  end
end
