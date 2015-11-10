Rottenpotatoes::Application.routes.draw do
  resources :movies do
    get 'same_director'
  end
  root 'movies#index'
end
