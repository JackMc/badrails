Rails.application.routes.draw do
  resources :blogs
  resources :users, except: [:index, :edit, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/admin/users', to: "admin/users#index"
  get '/admin/edit/:id', to: "admin/users#edit"
  patch '/admin/edit/:id', to: "admin/users#do_edit"
  delete '/admin/destroy/:id', to: "admin/users#destroy"
  get '/login', to: "users#login"
  post '/login', to: "users#do_login"
  get '/logout', to: "users#logout"

  root 'users#login'
end
