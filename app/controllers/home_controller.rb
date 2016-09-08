# Home class
class HomeController < ApplicationController
  def index
    if current_user
      if @deck = current_user.decks.current.first
        @card = @deck.cards.reviewed.random_cards.first
      else
        #byebug
        @card = current_user.cards.reviewed.random_cards.first
      end
      redirect_to decks_path if @card.nil?
    else
      redirect_to home_about_path
    end
  end
end
