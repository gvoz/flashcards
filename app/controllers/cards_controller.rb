# This class work with Flash Cards
class CardsController < ApplicationController
  before_action :require_login

  def show
    @deck = Deck.find(params[:deck_id])
    @card = @deck.cards.find(params[:id])
  end

  def new
    @deck = Deck.user_decks(current_user.id).find(params[:deck_id])
    @card = @deck.cards.build
  end

  def edit
    @deck = Deck.find(params[:deck_id])
    @card = @deck.cards.find(params[:id])
  end

  def create
    @deck = Deck.user_decks(current_user.id).find(params[:deck_id])
    @card = @deck.cards.build(card_params)

    if @card.save
      redirect_to deck_card_path(params[:deck_id], @card)
    else
      render 'new'
    end
  end

  def update
    @card = Card.find(params[:id])

    if @card.update(card_params)
      redirect_to deck_card_path(params[:deck_id], @card)
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to deck_path(params[:deck_id])
  end

  def checktranslate
    @card = Card.find(params[:id])
    if @card.check_translation?(params[:user_text])
      flash[:success] = "Правильный перевод"
      @card.change_review_date
    else
      flash[:error] = "Неправильный перевод"
    end
    redirect_to root_path
  end

  private

    def card_params
      params.require(:card).permit(:original_text.to_s.strip, :translated_text.to_s.strip, :review_date, :image, :remote_image_url)
    end
end
