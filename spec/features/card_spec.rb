require "rails_helper"
require "support/login_helper"

feature "Card managment", type: :feature do
  include CarrierWave::Test::Matchers
  let!(:user) { create :user }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, user: user, deck: deck) }

  before :each do
    login("email@email.com", "password")
  end

  context "Check translation" do
    it "correct" do
      fill_in :user_text, with: "hause"
      click_button "Проверить перевод"
      expect(page).to have_content "Правильный перевод"
    end

    it "misprint" do
      visit root_path
      fill_in :user_text, with: "hausse"
      click_button "Проверить перевод"
      expect(page).to have_content "Возможно допущена опечатка"
    end

    it "incorrect" do
      visit root_path
      fill_in :user_text, with: "battle"
      click_button "Проверить перевод"
      expect(page).to have_content "Неправильный перевод"
    end
  end

  context "image" do
    it "image on home page" do
      expect(page).to have_css("img[src*='images.jpeg']")
    end

    it "add image" do
      visit new_deck_card_path(deck)
      fill_in "card[original_text]", with: "hause"
      fill_in "card[translated_text]", with: "дом"
      attach_file "card[image]", "#{Rails.root}/spec/images/images.jpeg"
      click_button "Создать Карточку"
      expect(page).to have_css("img[src*='images.jpeg']")
    end
  end
end
