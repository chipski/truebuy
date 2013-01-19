Reviews::Application.routes.draw do

  
  resources :products do
    member do
      put :update_state
      get :content
      get :admin
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
      get :make_defaults
      post :create
    end
    member do
      post :make_default
    end
  end
   
  
  authenticated :user do
    root :to => 'home#index'
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