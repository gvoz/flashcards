require "rails_helper"
require "support/login_helper"

feature "Deck managment", type: :feature do
  let!(:user) { create(:user, email: "bob@mail.ru", password: "qweqweqwe") }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, deck: deck) }

  before :each do
    login("bob@mail.ru", "qweqweqwe")
  end

  it "Don't see card other decks" do
    other_deck = create(:deck, user: user)
    visit deck_path(other_deck)
    expect(page).not_to have_content "hause"
  end

  it "One current decks" do
    visit new_deck_path
    fill_in :deck_name, with: "Other deck"
    page.check(:deck_current)
    click_button "Create Deck"
    visit deck_path(deck)
    expect(page.has_checked_field?(:deck_current)).to be_falsey
  end

  it "Card from current deck on home page" do
    expect(page).to have_content "house"
  end

  it "Card on home page without current deck" do
    deck.update(current: false)
    card.destroy
    other_deck = create(:deck, user: user)
    create(:card, deck: other_deck, translated_text: "page", review_date: -15.days.from_now)
    visit root_path
    expect(page).to have_content "page"
  end
end
