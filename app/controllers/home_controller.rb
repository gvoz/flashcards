# Home class
class HomeController < ApplicationController
  def index
    @card = Card.reviewed.random_cards.first
    redirect_to cards_path if @card.nil?
  end
end
