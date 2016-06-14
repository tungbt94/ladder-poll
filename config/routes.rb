Rails.application.routes.draw do

  root to: "static_pages#welcome"

  resources :sessions, only: [:create, :destroy]
  resources :static_pages, only: [:welcome]
  resources :staffs
  resources :polls
  resources :options

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy'

  get 'static_pages_home', to: 'static_pages#home'

  get 'staff_edit', to: 'staffs#edit'
  # get 'staff_show', to: 'staffs#show'
  # get 'staff_index', to: 'staffs#index'

  # get 'poll_new', to: 'polls#new'
  # post 'poll_create', to: 'polls#create'
  # get 'poll_show', to: 'polls#show'
  # get 'poll_update', to: 'polls#update'
  # get 'polls_index', to: 'polls#index'
  get 'polls_destroy', to: 'polls#destroy'

  get 'update_key_person_staff', to:'staffs#update_key_person'

end
