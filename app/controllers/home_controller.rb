# Home class
class HomeController < ApplicationController
  def index
    @card = Card.reviewed.random_cards.first
    redirect_to cards_path, notice: "Нет актуальных карточек для перевода" if @card.nil?
  end
end
