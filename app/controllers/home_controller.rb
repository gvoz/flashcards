# Home class
class HomeController < ApplicationController
  def index
    if current_user
      @card = User.find(current_user).cards.reviewed.random_cards.first
      redirect_to cards_path if @card.nil?
    else
      redirect_to home_about_path
    end
  end
end
