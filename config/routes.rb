Rails.application.routes.draw do
  root :to => "users#home"
  resources :speakers, param: :slug
  devise_for :users
  namespace :admin do
    namespace :doublesecret do
      devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
    end
  end
  post "users/submit_inquiry"
end
