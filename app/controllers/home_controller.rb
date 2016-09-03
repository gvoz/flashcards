# Home class
class HomeController < ApplicationController
  def index
    if current_user
      @card = Card.user_cards(current_user.id).reviewed.random_cards.first
      redirect_to cards_path if @card.nil?
    else
      redirect_to home_about_path
    end
  end
end
