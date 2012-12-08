class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!, :except => [:error, :public, :thankyou]   
  after_filter :sniff_browser
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def sniff_browser
    Rails.logger.info("Browser=#{request.env['HTTP_USER_AGENT'] }")
  end
  
end
