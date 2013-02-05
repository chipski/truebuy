class UserMailer < ActionMailer::Base
  default :from => "chip@truebuy.com"
  layout 'email1'
  
  def welcome_email(user)
    mail(:to => user.email, :subject => "Invitation Request Received")
  end
end