require "rails_helper"
require "support/login_helper"

feature "Card managment", type: :feature do
  include CarrierWave::Test::Matchers
  let!(:user) { create(:user, email: "bob@mail.ru", password: "qweqweqwe") }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, deck: deck) }

  before :each do
    login("bob@mail.ru", "qweqweqwe")
  end

  it "Check user translation" do
    fill_in :user_text, with: "hause"
    click_button "Проверить перевод"
    expect(page).to have_content "Правильный перевод"
  end

  it "Last card" do
    fill_in :user_text, with: "hausse"
    click_button "Проверить перевод"
    expect(page).to have_content "Неправильный перевод"
  end

  it "Don't see card other users" do
    other_user = create(:user, email: "bob1@mail.ru", password: "pas")
    other_deck = create(:deck, user: other_user)
    create(:card, deck: other_deck)
    fill_in :user_text, with: "hause"
    click_button "Проверить перевод"
    expect(page).not_to have_content "Введите перевод"
  end

  it "image on home page" do
    expect(page).to have_css("img[src*='images.jpeg']")
  end

  it "image on show card page" do
    visit deck_path(deck)
    click_link "Показать"
    expect(page).to have_css("img[src*='images.jpeg']")
  end

  it "image on edit card page" do
    visit deck_path(deck)
    click_link "Редактировать"
    expect(page).to have_css("img[src*='images.jpeg']")
  end

  it "add image" do
    visit new_deck_card_path(deck)
    fill_in "card[original_text]", with: "hause"
    fill_in "card[translated_text]", with: "дом"
    attach_file "card[image]", "#{Rails.root}/spec/images/images.jpeg"
    click_button "Create Card"
    expect(page).to have_css("img[src*='images.jpeg']")
  end
end
