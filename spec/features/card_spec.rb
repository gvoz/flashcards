require "rails_helper"
require "support/login_helper"

feature "Card managment", type: :feature do
  include CarrierWave::Test::Matchers
  let!(:user) { create(:user, email: "bob@mail.ru", password: "qweqweqwe") }

  let!(:card) { create(:card, user: user) }

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
    create(:card, user: other_user)
    fill_in :user_text, with: "hause"
    click_button "Проверить перевод"
    expect(page).not_to have_content "Введите перевод"
  end

  it "image on home page" do
    expect(page).to have_css("img[src*='images.jpeg']")
  end

  it "image on show card page" do
    visit cards_path
    click_link "Показать"
    expect(page).to have_css("img[src*='images.jpeg']")
  end

  it "image on edit card page" do
    visit cards_path
    click_link "Редактировать"
    expect(page).to have_css("img[src*='images.jpeg']")
  end

  it "add image" do
    visit new_card_path
    fill_in "card[original_text]", with: "hause"
    fill_in "card[translated_text]", with: "дом"
    attach_file "card[image]", "#{Rails.root}/spec/images/images.jpeg"
    click_button "Create Card"
    expect(page).to have_css("img[src*='images.jpeg']")
  end
end
