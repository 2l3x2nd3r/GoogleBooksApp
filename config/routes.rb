Rails.application.routes.draw do

  get '/about' => 'annexes#about', as: :About
  get '/documentation' => 'annexes#documentation', as: :Documentation
  get '/contact' => 'annexes#contact', as: :Contact
  
  root 'welcome#index'
  get '/home' => 'welcome#home', as: :Home
  
  get 'books/show'
  
  resources :password_resets, except: [:index, :destroy]
  resources :confirmations, only: :show
  resources :sessions, only: [:create, :destroy]
  resources :users, except: [:new]

  get '/singup' => 'users#new', as: :Singup
  get '/login' => 'sessions#new', as: :Login

  get 'users/:username' => 'users#show'
  put 'users/:username' => 'users#update'
  delete 'users/:username' => 'users#destroy'
  get 'users/:username/edit' => 'users#edit'
  
end