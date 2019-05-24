Rails.application.routes.draw do
  root to: 'welcome#index'
  get 'signup'  => 'users#new'
  get 'login'  => 'users#login_form'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :challenges do
    member do
      get :new_post
    end
  end
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
