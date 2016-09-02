require "rails_helper"
require "support/login_helper"

feature "Card managment", type: :feature do
  let!(:user) { create(:user, email: "bob@mail.ru", password: "qweqweqwe") }

  let!(:card) { create(:card, user: user) }

  before(:each) do
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
end
