require "rails_helper"
require "support/login_helper"

feature "Deck managment", type: :feature do
  let!(:user) { create :user }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, user: user, deck: deck) }

  before :each do
    login("email@email.com", "password")
  end

  context "One deck" do
    it "Card from current deck on home page" do
      expect(page).to have_content "house"
    end

    it "Card on home page without current deck" do
      deck.update(current: false)
      visit root_path
      expect(page).to have_content "house"
    end
  end

  context "Few decks" do
    let!(:other_deck) { create(:deck, user: user) }

    it "Don't see card other decks" do
      visit deck_path(other_deck)
      expect(page).not_to have_content "hause"
    end

    it "One current decks" do
      visit deck_path(deck)
      expect(page.has_checked_field?(:deck_current)).to be_falsey
    end
  end

  context "Few users" do
    let!(:other_user) { create :user, email: "bob@mail.ru", password: "pas" }

    before :each do
      click_link "Выйти"
      login("bob@mail.ru", "pas")
    end

    it "Don't see card other users" do
      expect(page).not_to have_content "Введите перевод"
    end

    it "Don't see deck other users" do
      visit decks_path
      expect(page).not_to have_content "test deck"
    end
  end
end
