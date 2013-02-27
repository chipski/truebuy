Reviews::Application.routes.draw do

  resources :companies, :path => 'co' do
    resources :photos
    member do
      put :update_state
      get :content
      get :admin
    end
  end
  resources :brands, :path => 'br' do
    resources :photos
    member do
      put :update_state
      get :content
      get :admin
    end
  end
  
  resources :stores, :path=> 'store' do
    member do
      get :update_products
    end
  end
  resources :locations, :path => 'loc' do
    member do
      put :update_location
    end
  end
  resources :categories, :path => 'cat' do
    resources :photos
    resources :brands
    resources :companies
    member do
      put :update_state
      get :content
      get :admin
    end
  end
  resources :products, :path => 'prod' do
    member do
      put :update_state
      get :content
      get :admin
    end
  end
  resources :reviews do
    collection do
      get :new_modal
    end
  end

  #resources :topics
  resources :topics, :path => 'to' do
    resources :photos
    collection do
      post :create
    end
    member do
      put :update_state
      get :content
      get :admin
    end
  end
  resources :photos
  resources :photos do
    collection do
      post :create
    end
    member do
      post :make_default
      put :update_state
    end
  end
   
  authenticated :user do
    resources :users do
      member do
        get :invite
        get :update_role
        get :edit_admin
        put :update_admin
      end
    end
    
    match '/rate' => 'rater#create', :as => 'rate'
    root :to => 'categories#index'
  end
  
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "/login",  :to => "devise/sessions#new", :as => :login  
    get "/logout", :to => "devise/sessions#destroy", :as => :logout
    get "/signup", :to => "devise/registrations#new", :as => :signup     
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
    match '/confirm/:confirmation_token', :to => "devise/confirmations#show", :as => "user_confirm", :only_path => false
    
    match '/users/auth/facebook/callback', to: 'users/omniauth_callbacks#facebook'
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    match '/users/auth/:provider/callback', to: 'sessions#create_omni'

    root :to => "devise/registrations#new"
  end
  devise_for :users, :controllers => { :registrations => "registrations", :confirmations => "confirmations", :omniauth_callbacks => "users/omniauth_callbacks" }
  match 'users/bulk_invite/:quantity' => 'users#bulk_invite', :via => :get, :as => :bulk_invite
  
  resources :users, :only => [:show, :index] do
    get 'invite', :on => :member
  end

  match '/about'   => 'home#about'
  match '/tos'     => 'home#tos'
  match '/privacy' => 'home#privacy'
  
  
end