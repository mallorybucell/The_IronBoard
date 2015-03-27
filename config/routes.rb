Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

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
      get   '/games/:gamename/recent' =>  'games#recent_game'
    end
  end

  get   '/invite'   => 'static_pages#new',    as: 'new_invite'
  post  '/invite'   => 'static_pages#create', as: 'create_invite'

  root 'static_pages#home' 

end
