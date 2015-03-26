module V1
  class GamesController < ApiController
    def list
      @games = Game.all
    end
  end
end