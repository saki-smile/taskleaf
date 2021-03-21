Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  root 'tasks#index'
  resources :tasks
end
