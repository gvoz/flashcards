# Home class
class HomeController < ApplicationController
  def index
    @card = User.find(current_user).cards.reviewed.random_cards.first unless current_user.nil?
    redirect_to cards_path if @card.nil?
  end
end
