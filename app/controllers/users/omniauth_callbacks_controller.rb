class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
   include Devise::Controllers::Rememberable

   def facebook
     @user = User.configure_facebook_user(request.env["omniauth.auth"], params[:code])
     if @user.persisted?
       remember_me @user
       sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
       set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
     else
       session["devise.facebook_data"] = request.env["omniauth.auth"]
       redirect_to new_user_registration_url
     end
   end
   
   def passthru
     render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
     # Or alternatively,
     # raise ActionController::RoutingError.new('Not Found')
   end

 end