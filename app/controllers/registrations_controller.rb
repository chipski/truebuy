class RegistrationsController < Devise::RegistrationsController

  def new
    @company = Company.default_home
    #render "companies/show"
  end
  
  # ovverride #create to respond to AJAX with a partial
  def create
    build_resource
    if resource.save
      Rails.logger.info("User.create saved ok #{resource}")
      if resource.active_for_authentication?
        sign_in(resource_name, resource)
        (render(:partial => 'thankyou', :layout => false) && return)  if request.xhr?
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        expire_session_data_after_sign_in!
        (render(:partial => 'thankyou', :layout => false) && return)  if request.xhr?
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      Rails.logger.info("User.create save error for #{resource} error=#{resource.errors}")
      clean_up_passwords resource
      respond_to do |format|
        format.html { 
          #render :action => :new, :layout => !request.xhr? 
          render :partial=>"devise/registrations/invite_modal", :locals=>{:user=>@user}
        }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      
      end
    end
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    '/thankyou.html'
  end

  def after_sign_up_path_for(resource)
    # the page new users will see after sign up (after launch, when no invitation is needed)
    redirect_to root_path
  end

end