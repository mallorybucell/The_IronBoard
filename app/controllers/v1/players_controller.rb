module V1
  class PlayersController < ApiController
    
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])

    end
    

    #FIXME Fix specs for recent_games
    def recent_games
      lim = if params[:limit].to_i > 0
        params[:limit].to_i
      else
        20
      end
      user = User.find(params[:id].to_i)
      @games = user.games.order(created_at: :desc).limit(lim)
    end
  end
end