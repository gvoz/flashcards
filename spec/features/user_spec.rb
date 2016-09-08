require "rails_helper"
require "support/login_helper"

feature "User managment", type: :feature do
  let!(:user) { create :user }
  before :each do
    login("email@email.com", "password")
  end

  it "Login" do
    expect(page).to have_content "Вы вошли"
  end

  it "Logout" do
    click_link "Выйти"
    expect(page).to have_content "Вы вышли"
  end

  it "Incorrect login" do
    click_link "Выйти"
    login("bob@mail.ru", "pas")
    expect(page).to have_content "Email или пароль неправильные"
  end
end
