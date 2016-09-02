require "rails_helper"

describe Card do

  it "wrong translation" do
    card = build(:card)
    expect(card.check_translation?("battlestart")).to be false
  end

  it "correct translation" do
    card = build(:card)
    expect(card.check_translation?("hause")).to be true
  end

  it "case-sensitive translation" do
    card = build(:card)
    expect(card.check_translation?("HauSe")).to be true
  end

  it "extra spaces translation" do
    card = build(:card)
    expect(card.check_translation?("   hause    ")).to be true
  end

  it "change review date" do
    card = build(:card)
    card.change_review_date
    expect(card.review_date.strftime("%d/%m/%Y")).to eq 3.days.from_now.strftime("%d/%m/%Y")
  end
end
