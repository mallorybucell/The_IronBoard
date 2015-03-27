module V1
  class PlayersController < ApiController
    
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])

    end

    def recent_games
      lim = params[:limit] || 20
      user = User.find(:id)
      @games = user.games.order(created_at: :desc).limit(lim)
    end
  end
end