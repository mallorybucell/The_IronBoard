Rails.application.routes.draw do
  devise_for :users

  # resources :tokens, only: [:create, :destroy] do
  # end

  # root 'leaderboard#leaderboard'

  scope :api do
    namespace :v1 do
      get '/players'                  => 'players#index'
      get '/players/:id'              => 'players#show'
      get '/players/:id/recent_games' => 'players#recent_games'

      get   '/games'                  =>  'games#list'
      post  '/games'                  =>  'games#create'
      get   '/games/:id'              =>  'games#show'
      get   '/games/:gamename'        =>  'games#index'
      get   '/games/recent'           =>  'games#recent'
      # get   '/games/:gamename/recent' =>  
    end
  end

  root 'application#home' 
end
