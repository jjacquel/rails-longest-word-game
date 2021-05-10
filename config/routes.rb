Rails.application.routes.draw do
  get '/new', to: "games#new", as: :new
  post '/score', to: "games#score", as: :score
  patch '/reset', to: "games#reset", as: :reset
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
