# this class work with Flash Cards
class CardsController < ApplicationController
  before_action :require_login

  def show
    card
  end

  def new
    @card = deck.cards.new
  end

  def edit
    card
  end

  def create
    @card = deck.cards.new(card_params)
    @card.user_id = current_user.id
    if @card.save
      redirect_to deck_card_path(deck, @card)
    else
      render 'new'
    end
  end

  def update
    if card.update(card_params)
      redirect_to deck_card_path(deck, @card)
    else
      render 'edit'
    end
  end

  def destroy
    card.destroy
    redirect_to deck_path(deck)
  end

  def checktranslate
    @card = Card.find(params[:id])
    if @card.check_translation?(params[:user_text])
      flash[:success] = "Правильный перевод"
      @card.increase_review_interval
    else
      flash[:error] = "Неправильный перевод"
      @card.change_number_of_mistakes
    end
    redirect_to root_path
  end

  private

    def card_params
      params.require(:card).permit(:original_text.to_s.strip, :translated_text.to_s.strip, :review_date, :image, :remote_image_url)
    end

    def deck
      @deck = current_user.decks.find(params[:deck_id])
    end

    def card
      @card = deck.cards.find(params[:id])
    end
end
