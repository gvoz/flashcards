# This class work with Flash Cards
class CardsController < ApplicationController
  before_filter :require_login

  def index
    @cards = User.find(current_user).cards.all
  end

  def show
    @card = User.find(current_user).cards.find(params[:id])
  end

  def new
    @card = User.find(current_user).cards.new
  end

  def edit
    @card = User.find(current_user).cards.find(params[:id])
  end

  def create
    @card = User.find(current_user).cards.new(card_params)

    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end

  def update
    @card = User.find(current_user).cards.find(params[:id])

    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card = User.find(current_user).cards.find(params[:id])
    @card.destroy

    redirect_to cards_path
  end

  def checktranslate
    @card = User.find(current_user).cards.find(params[:id])
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
