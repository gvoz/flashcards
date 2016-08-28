# This class work with Flash Cards
class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
    @card = Card.new
  end

  def edit
    @card = Card.find(params[:id])
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end

  def update
    @card = Card.find(params[:id])

    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to cards_path
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
      params.require(:card).permit(:original_text.to_s.strip, :translated_text.to_s.strip, :review_date)
    end
end
