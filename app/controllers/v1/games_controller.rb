module V1
  class GamesController < ApiController

    def create
      head :ok
    end

    def list
      @games = Game.all
    end

    def show
      @game = Game.find(params[:id])
    end
  
  end

end