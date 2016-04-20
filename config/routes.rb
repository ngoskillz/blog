Rails.application.routes.draw do
  devise_for :users,  :controllers => { :registrations => "users/registrations" }
  resources :users

  # Creating a new resource article
  resources :articles do
    resources :comments
  end

  # Home page  
  root 'home#index'

  # Welcome page
  get 'welcome/index'

  # Navbar items
  get "categories" => "home#categories", as: :categories
  get "video" => "home#video", as: :video
  get "about" => "home#about", as: :about
  get "contact" => "home#contact", as: :contact

  # TODO: Implement this if needed
  # User List
  # get "user" => "users#index", as: :user

  # Admin stuff
  get "admin" => "users_management#index", as: :admin

  # Users management pages for admins
  get 'users_management/_form'
  get 'users_management/index'
  get 'users_management/edit'
  get 'users_management/new'
  get 'users_management/show'
end
