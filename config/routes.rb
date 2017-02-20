Rails.application.routes.draw do
  resources :sites
  resources :bookmarks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'bookmarks#index', as: 'home'
  
end
