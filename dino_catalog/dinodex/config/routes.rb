Rails.application.routes.draw do
  root 'dinosaur#index'
  resources :dinosaur
end
