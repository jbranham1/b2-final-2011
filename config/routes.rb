Rails.application.routes.draw do
  resources :flights, only: [:index, :show] do
    resources :passengers, controller: "flight_passengers", only: [:destroy]
  end
end
