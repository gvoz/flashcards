# Home class
class HomeController < ApplicationController
  def index
    @card = Card.reviewed.random_cards.first
  end
end
