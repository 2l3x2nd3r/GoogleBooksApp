Rails.application.routes.draw do

  get 'annexes/about', as: :About
  get 'annexes/documentation', as: :Documentation
  get 'annexes/contact', as: :Contact
  
  root 'welcome#index'
  
  get 'books/show'
  
  resources :password_resets, except: [:index, :destroy]
  resources :confirmations, only: :show
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  get 'users/:username' => 'users#show'
  put 'users/:username' => 'users#update'
  delete 'users/:username' => 'users#destroy'
  get 'users/:username/edit' => 'users#edit'

  
  
end