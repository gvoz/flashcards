require "rails_helper"
require "support/login_helper"

feature "User managment", type: :feature do
  let!(:user) { create(:user, email: "bob@mail.ru", password: "qweqweqwe") }

  it "Login" do
    login("bob@mail.ru", "qweqweqwe")
    expect(page).to have_content "Вы вошли"
  end

  it "Incorrect login" do
    login("bob@mail.ru", "qweqweqqq")
    expect(page).to have_content "Email или пароль неправильные"
  end

  it "Logout" do
    login("bob@mail.ru", "qweqweqwe")
    click_link "Выйти"
    expect(page).to have_content "Вы вышли"
  end
end
