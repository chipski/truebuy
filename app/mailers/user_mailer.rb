class UserMailer < Devise::Mailer
  default :from => "info@truebuy.com"
  layout 'email'
  
  def welcome_email(user)
    @resource = user
    @site_url = root_url,
    @site_logo = root_url+"/assets/logo.png"
    #@mixpanel_tracking_pixel = Mixpanel::Tracker.new("#{APP_CONFIG['analytics']['mixpanel']}").tracking_pixel("Open Email Welcome", {"distinct_id" => user.email}) 
    mail(
      to: @resource.email,
      subject: "Welcome to Truebuy",
      from: "Truebuy <info@truebuy.com>"
      )
  end
  
  def confirmation_instructions(user)
    @resource = user
    @site_url = root_url,
    @site_logo = root_url+"/assets/logo.png"
    @hero_url = root_url+"/assets/hero1.png"
    mail(
      to: @resource.email
      )
  end

  def reset_password_instructions(user)
    @resource = user
    @site_url = root_url,
    @site_logo = root_url+"/assets/logo.png"
    mail to: @resource.email
  end

  def unlock_instructions(user)
    @resource = user
    @site_url = root_url,
    @site_logo = root_url+"/assets/logo.png"
    mail to: @resource.email
  end
  
  private
    def set_links(user)
     @site_url = root_url
     @site_logo = root_url+"/assets/logo.png"
   end
end
