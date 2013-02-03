Mailjet.configure do |config|
  config.api_key = APP_CONFIG['mailjet']['api_key']
  config.secret_key = APP_CONFIG['mailjet']['secret_key']
  config.default_from = APP_CONFIG['mailjet']['default_from']
end