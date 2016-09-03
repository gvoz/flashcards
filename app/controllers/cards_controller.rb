# This class work with Flash Cards
class CardsController < ApplicationController
  before_action :require_login

  def index
    @cards = Card.user_cards(current_user.id).all
  end

  def show
    @card = Card.user_cards(current_user.id).find(params[:id])
  end

  def new
    @card = Card.user_cards(current_user.id).new
  end

  def edit
    @card = Card.user_cards(current_user.id).find(params[:id])
  end

  def create
    @card = Card.user_cards(current_user.id).new(card_params)

    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end

  def update
    @card = Card.user_cards(current_user.id).find(params[:id])

    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.user_cards(current_user.id).find(params[:id])
    @card.destroy

    redirect_to cards_path
  end

  def checktranslate
    @card = Card.user_cards(current_user.id).find(params[:id])
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
      params.require(:card).permit(:original_text.to_s.strip, :translated_text.to_s.strip, :review_date)
    end
end
