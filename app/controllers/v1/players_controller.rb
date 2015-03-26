module V1
  class PlayersController < ApiController
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def recent_games
      @games = User.games
    end
  end
end