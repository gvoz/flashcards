require "rails_helper"

feature "Card managment", :type => :feature do
  scenario "No card to translate" do
    visit root_path
    expect(page).to have_content "Нет актуальных карточек для перевода"
  end

  scenario "Check user translation" do
    card = create(:card)
    card2 = create(:card)
    visit root_path
    fill_in :user_text, :with => "hause"
    click_button "Проверить перевод"
    expect(page).to have_content "Правильный перевод"
  end

  scenario "Last card" do
    card = create(:card)
    visit root_path
    fill_in :user_text, :with => "hause"
    click_button "Проверить перевод"
    expect(page).to have_content "Нет актуальных карточек для перевода"
  end
end
