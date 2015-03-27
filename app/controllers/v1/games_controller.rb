module V1
  class GamesController < ApiController

    def create
      data = params
      Game.new_game data
      if response.status == 200
        head :ok
      end
    end

    def list
      @games = Game.all
    end

    def show
      @game = Game.find(params[:id])
    end
  
    def index
      @games = Game.where(name: params[:gamename])
    end

    def recent
      @games = Game.all.reverse.take(15)
    end

    def recent_game
      @games = Game.where(name: params[:gamename]).reverse.take(5)
    end
  end

end