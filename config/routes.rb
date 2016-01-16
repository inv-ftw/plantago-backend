Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'application#landing'
  match 'info', to: 'application#info', via: :get, as: :info
  resources :clinics, only: :index
end
