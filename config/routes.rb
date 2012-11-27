Reviews::Application.routes.draw do

  resources :categories
  
  resources :photos do
    collection do
      post 'make_default'
    end
  end
  resources :topics do
    resources :photos do
      collection do
        post 'make_default'
        get :make_default
      end
    end
  end  
   
  #resources :companies
  resources :companies do
    resources :topics do
      collection do
        post 'make_default'
      end
    end
    resource :photo do
      member do
        post 'make_default'
      end
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