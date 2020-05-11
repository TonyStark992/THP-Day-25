Rails.application.routes.draw do
  get '/', to: 'gossips#index'
  get 'team', to: 'static_pages#team'
  get 'contact', to: 'static_pages#contact'
  resources :gossips do
    resources :comments, except: [:index, :show]
  end
  resources :cities, only: [:show]
  resources :users, only: [:show, :new, :create]
  resources :sessions, only: [:new, :create, :destroy]
end
