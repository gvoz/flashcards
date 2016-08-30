require "rails_helper"

feature "Card managment", type: :feature do
  let!(:card) { create(:card) }

  before(:each) do
    visit root_path
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
end
