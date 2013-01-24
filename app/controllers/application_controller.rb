class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #before_filter :authenticate_user!, :except => [:error, :public, :thankyou]   
  after_filter :sniff_browser
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def sniff_browser
    Rails.logger.info("Browser=#{request.env['HTTP_USER_AGENT'] }")
  end
  
  def update_entity_state(entity, state="error")
    case params[:state] 
    when "active"
      entity.mark_active    
      puts "#{entity.class}.update_state marked active "
    when "inactive" 
      entity.mark_inactive    
      puts "#{entity.class}.update_state marked mark_inactive "
    when  "review" 
      entity.mark_review    
      puts "#{entity.class}.update_state marked mark_review "
    when "launch" 
      entity.mark_launch    
      puts "#{entity.class}.update_state marked mark_launch "
    when  "list_only" 
      entity.mark_list_only    
      puts "#{entity.class}.update_state marked mark_list_only "
      return_to = admin_new_campaigns_path
    when "admin_only" 
      entity.mark_admin_only    
      puts "#{entity.class}.update_state marked mark_admin_only "
    when  "error" 
      entity.mark_error    
      puts "#{entity.class}.update_state marked mark_error "
    end     
    Rails.logger.info("Update_state for #{entity.class.name} id=#{entity.id} to #{state}") 
    entity
  end
  
  
  def content
    resource
    respond_to do |format|
      format.html { render :show }
      format.js { render :partial=>'shared/content', :locals=>{:collection=>resource.topics}, :layout=>false }
    end
  end
  def admin
    resource
    respond_to do |format|
      format.html { render :show }
      format.js { render :partial=>'photos/upload_form', :locals=>{:parent=>resource}, :layout=>false }
    end
  end
  
end
