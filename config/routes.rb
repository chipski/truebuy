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
   
  match '/about' => 'home#about'
  match '/tos' => 'home#tos'
  match '/privacy' => 'home#privacy'
  
  authenticated :user do
    
    match '/rate' => 'rater#create', :as => 'rate'
    root :to => 'categories#index'
  end
  devise_scope :user do
    root :to => "devise/registrations#new"
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end
  devise_for :users, :controllers => { :registrations => "registrations", :confirmations => "confirmations" }
  match 'users/bulk_invite/:quantity' => 'users#bulk_invite', :via => :get, :as => :bulk_invite
  resources :users, :only => [:show, :index] do
    get 'invite', :on => :member
  end
  
end