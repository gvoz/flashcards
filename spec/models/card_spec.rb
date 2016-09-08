require "rails_helper"

describe Card do
  let!(:user) { create :user }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { build(:card, user: user, deck: deck) }

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

  it "change review date" do
    card.change_review_date
    expect(card.review_date.strftime("%d/%m/%Y")).to eq 3.days.from_now.strftime("%d/%m/%Y")
  end
end
