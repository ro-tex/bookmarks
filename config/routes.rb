Rails.application.routes.draw do

  # We need this for the "bookmark.1" format.
  # It also needs to be above 'resources :bookmarks'.
  resource :bookmarks

  resources :sites
  resources :bookmarks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'bookmarks#index', as: 'home'
end
