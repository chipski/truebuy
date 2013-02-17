class SessionsController < Devise::SessionsController
  

  def create_omni
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    #redirect_to '/'
    respond_with current_user, :location => after_sign_in_path_for(current_user)
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end