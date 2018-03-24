Rails.application.routes.draw do
  root :to => "users#home"
  resources :speakers, param: :slug
  resources :cities, param: :slug
  resources :schedules, param: :slug
  resources :sponsor_logos
  resources :schedule_panels, only: [:destroy, :update, :create, :edit]
  namespace :admin do
    namespace :doublesecret do
      devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
    end
  end
  post "users/submit_inquiry"
  post "cities/add_sponsor_logo"
  post "cities/remove_sponsor_logo"
  post "schedules/:id/create" => "schedules#create", :as => "schedule_create"
  get  "about" => "users#about"
end
