ActionMailer::Base.smtp_settings = {
  :address   => "smtp.mandrillapp.com",
  :port      => 587, # 25 or 587
  :enable_starttls_auto => true, # detects and uses STARTTLS
  :user_name => APP_CONFIG['mandrill']['username'],
  :password  => APP_CONFIG['mandrill']['api_key'],
  :domain => APP_CONFIG['mandrill']['domain'],
  :authentication => 'login' # Mandrill supports 'plain' or 'login'
}