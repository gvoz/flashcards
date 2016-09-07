# Home class
class HomeController < ApplicationController
  def index
    if current_user
      @deck = Deck.user_decks(current_user.id).current
      @deck = Deck.user_decks(current_user.id) if @deck.first.nil?
      if @deck.first.nil?
        redirect_to decks_path
      else
        @card = Card.deck_cards(@deck.ids).reviewed.random_cards.first
        redirect_to deck_path(@deck.first) if @card.nil?
      end
    else
      redirect_to home_about_path
    end
  end
end
