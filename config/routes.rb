Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_scope :user do
    resource :password,
      path: 'users/passwort',
      controller: 'users/passwords',
      path_names: { new: 'neu' }
    resource :confirmation,
      only: [:new, :create, :show],
      path: 'users/bestaetigung',
      controller: 'users/confirmations',
      path_names: { new: 'neu' }
    resource :registration,
      only: [:new, :create, :destroy],
      path: 'users',
      controller: 'users/registrations',
      path_names: { new: 'registrierung' } do
        post :set_address
        get :graetzls
      end

    post 'users/notification_settings/toggle_website_notification', to: 'notification_settings#toggle_website_notification', as: :user_toggle_website_notification
    post 'users/notification_settings/change_mail_notification', to: 'notification_settings#change_mail_notification', as: :user_change_mail_notification
  end

  devise_for :users, skip: [:passwords, :confirmations, :registrations],
    controllers: {
      sessions: 'users/sessions',
    },
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
    }

  resources :users, only: [:show, :update]

  resource :user, only: [:edit], path_names: { edit: 'einstellungen' } do
    resources :locations, module: :users, only: [:index]
    resources :zuckerls, path: 'zuckerl', module: :users, only: [:index]
  end

  concern :graetzl_before_new do
    collection do
      post 'new', as: :before_new
    end
  end

  resources :activities, only: [:index]
  resources :meetings, path: :treffen, except: [:show]
  resources :zuckerls, only: [:index]
  resources :rooms, only: [:index]
  resources :posts, only: [:index]
  resources :locations do
    concerns :graetzl_before_new
    resources :meetings, module: :locations, path: :treffen, only: [:new, :create]
    resources :zuckerls, path: 'zuckerl', except: [:index, :show]
  end

  resource :wien, controller: 'wien', only: [:show] do
    get 'visit_graetzl'
    get 'treffen', action: 'meetings', as: 'meetings'
    get 'locations'
    get 'raumteiler', action: 'rooms', as: 'rooms'
    get 'zuckerl', action: 'zuckerls', as: 'zuckerls'
  end

  resources :districts, path: 'wien', only: [:show] do
    get :graetzls, on: :member
    resources :locations, module: :districts, only: [:index]
    resources :meetings, path: :treffen, module: :districts, only: [:index]
    resources :zuckerls, path: :zuckerl, module: :districts, only: [:index]
  end

  get 'info/agb', to: 'static_pages#agb'
  get 'info/datenschutz', to: 'static_pages#datenschutz'
  get 'info/impressum', to: 'static_pages#impressum'
  get 'info/infos-zum-graetzlzuckerl', to: 'static_pages#zuckerl'
  get 'info/fragen-und-antworten', to: 'static_pages#faq'
  get 'info/infos-zur-graetzlmarie', to: 'static_pages#graetzlmarie'
  get 'hilfe', to: 'static_pages#help'
  get '/robots.txt' => 'static_pages#robots'

  root 'static_pages#home'

  resources :notifications, only: [ :index ] do
    post :mark_as_seen, on: :collection
  end

  resources :room_offers do
    get 'select', on: :collection
  end

  resources :room_demands

  resources :going_tos, only: [:create, :destroy]

  resources :zuckerls, path: 'zuckerl', only: [:new] do
    resource :billing_address, only: [:show, :create, :update]
  end

  resources :comments, only: [:create, :destroy]

  resources :posts, only: [:destroy]

  resources :location_posts, only: [:create] do
    post :comments, action: :comment
    get :comments
  end
  resources :admin_posts, path: :ideen, only: [:show]

  namespace :api do
    resources :meetings, only: [:index]
  end

  resources :graetzls, path: '', only: [:show] do
    get 'treffen', action: 'meetings', as: 'meetings', on: :member
    get 'locations', on: :member
    get 'raumteiler', action: 'rooms', as: 'rooms', on: :member
    get 'zuckerl', action: 'zuckerls', as: 'zuckerls', on: :member
    get 'ideen', action: 'posts', as: 'posts', on: :member
    resources :meetings, path: :treffen, module: :graetzls, except: [:index, :edit, :update, :destroy]
    resources :locations, only: [:show]
    resources :users, only: [:show]
    resources :user_posts, path: :ideen, only: [:new, :create, :show]
  end

end
