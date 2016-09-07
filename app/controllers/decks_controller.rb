# this class work with Decks
class DecksController < ApplicationController
  before_action :require_login

  def index
    @decks = Deck.user_decks(current_user.id).all
  end

  def show
    @deck = Deck.find(params[:id])
  end

  def new
    @deck = Deck.user_decks(current_user.id).new
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def create
    @deck = Deck.user_decks(current_user.id).new(deck_params)

    if @deck.save
      redirect_to @deck
    else
      render 'new'
    end
  end

  def update
    @deck = Deck.find(params[:id])

    if @deck.update(deck_params)
      redirect_to @deck
    else
      render 'edit'
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy

    redirect_to decks_path
  end

  private

  def deck_params
    params.require(:deck).permit(:name.to_s, :description.to_s, :current)
  end
end
