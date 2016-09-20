# Home class
class HomeController < ApplicationController
  def index
    if current_user
      @card =
        if @deck = current_user.decks.current.first
          @deck.cards.reviewed.random_cards.first
        else
          current_user.cards.reviewed.random_cards.first
        end
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_to home_about_path
    end
  end
end
