require "rails_helper"

feature "Card managment", :type => :feature do
  scenario "Check user translation" do
    visit root_path
    fill_in :user_text, :with => "du"
    click_button "Проверить перевод"

    expect(page).to have_content "Неправильный перевод"
  end
end
