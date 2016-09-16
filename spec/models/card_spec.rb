require "rails_helper"

describe Card do
  let!(:user) { create :user }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, user: user, deck: deck) }

  context "check translation" do
    it "wrong translation" do
      quality = Quality.check_translate(card, "battlestart")
      expect(quality.error?).to be true
    end

    it "correct translation" do
      quality = Quality.check_translate(card, "hause")
      expect(quality.success?).to be true
    end

    it "case-sensitive translation" do
      quality = Quality.check_translate(card, "HauSe")
      expect(quality.success?).to be true
    end

    it "misprint" do
      quality = Quality.check_translate(card, "   hause    ")
      expect(quality.success?).to be true
    end

    it "extra spaces translation" do
      quality = Quality.check_translate(card, "haues")
      expect(quality.misprint?).to be true
    end
  end

  context "calculation review interval" do
    context "change repeat" do
      it "repeat up" do
        SuperMemo.change_interval(card, 0)
        expect(card.repeat).to eq 2
      end

      it "repeat reset" do
        card.repeat = 5
        SuperMemo.change_interval(card, 3)
        expect(card.repeat).to eq 1
      end
    end

    context "change efactor" do
      it 'change if quality >= 3' do
        SuperMemo.change_interval(card, 0)
        expect(card.efactor).to eq 2.5 + (0.1 - (5 - 5) * (0.08 + (5 - 5) * 0.02))
      end

      it 'change if quality < 3' do
        efactor = card.efactor
        SuperMemo.change_interval(card, 3)
        expect(card.efactor).to eq efactor
      end

      it 'not more 1.3' do
        card.efactor = 1.3
        SuperMemo.change_interval(card, 2)
        expect(card.efactor).to eq 1.3
      end
    end

    context "change interval" do
      it 'when repeat 1' do
        card.repeat = 0
        SuperMemo.change_interval(card, 0)
        expect(card.review_interval).to eq 1
      end

      it 'when repeat 2' do
        SuperMemo.change_interval(card, 0)
        expect(card.review_interval).to eq 6
      end

      it "interval reset" do
        card.review_interval = 6
        SuperMemo.change_interval(card, 3)
        expect(card.review_interval).to eq 1
      end

      it 'use efactor' do
        card.repeat = 2
        SuperMemo.change_interval(card, 0)
        expect(card.review_interval).to eq 7.0 * (2.5 + (0.1 - (5 - 5) * (0.08 + (5 - 5) * 0.02)))
      end
    end
  end
end
