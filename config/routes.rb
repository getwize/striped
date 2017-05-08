Rails.application.routes.draw do
  resources :students
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

  get 'owner' => 'students#owner'

  get 'pages/home'

  get 'pages/about'

  get 'pages/contact'

  get 'pages/blog'

  root 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
