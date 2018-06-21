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
  post "users/activate"
  post "users/destroy"
  post "cities/add_sponsor_logo"
  post "cities/remove_sponsor_logo"
  post "schedules/:id/create" => "schedules#create", :as => "schedule_create"
  post "schedule_panels/:id/remove_speaker" => "schedule_panels#remove_speaker"
  post "schedule_panels/:id/add_speaker" => "schedule_panels#add_speaker"
  get  "about" => "users#about"
  get  "users" => "users#index"
end
