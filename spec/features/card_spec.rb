require "rails_helper"

feature "Card managment", :type => :feature do
  before(:each) do
    card = create(:card)
  end

  scenario "No card to translate" do
    visit root_path
    expect(page).to have_content "Нет актуальных карточек для перевода"
  end

  scenario "Check user translation" do
    visit root_path
    fill_in :user_text, :with => "und"
    click_button "Проверить перевод"
    expect(page).to have_content "Правильный перевод"
  end
end
