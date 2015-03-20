Rails.application.routes.draw do
  devise_for :users
  
  root 'application#index'

  get '/games/new' => 'games#new'

  post '/games/new' => 'games#play'

  post '/games/play' => 'games#play', as: 'games_play'

  #get '/games/play' => 'games#play'
end
