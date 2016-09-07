# Home class
class HomeController < ApplicationController
  def index
    if false #current_user
      @card = Card.reviewed.random_cards.first
      redirect_to deck_cards_path if @card.nil?
    else
      redirect_to home_about_path
    end
  end
end
