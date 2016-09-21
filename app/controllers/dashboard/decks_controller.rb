module Dashboard
  # this class work with Decks
  class DecksController < Dashboard::ApplicationController
    before_action :require_login

    def index
      @decks = current_user.decks.order_current
    end

    def show
      deck
    end

    def new
      @deck = current_user.decks.new
    end

    def edit
      deck
    end

    def create
      @deck = current_user.decks.new(deck_params)
      if @deck.save
        @deck.make_current if @deck.current
        redirect_to @deck
      else
        render 'new'
      end
    end

    def update
      deck
      if @deck.update(deck_params)
        @deck.make_current if @deck.current
        redirect_to deck
      else
        render 'edit'
      end
    end

    def destroy
      deck.destroy
      redirect_to decks_path
    end

    private

    def deck_params
      params.require(:deck).permit(:name, :description, :current)
    end

    def deck
      @deck = current_user.decks.find(params[:id])
    end
  end
end
