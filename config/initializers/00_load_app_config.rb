
# Depending on the Rails.env load from a YAML file or config variables
APP_CONFIG = Hash.new
if File.exists? File.join(Rails.root, 'config', 'app_config.yml')
  settings = YAML.load_file(File.join(Rails.root, "/config/app_config.yml"))
  APP_CONFIG.merge! settings[Rails.env]
else
  env_config = {
    'dropbox' => {
      'app_key' => ENV['DROPBOX_APP_KEY'],
      'app_secret' => ENV['DROPBOX_APP_SECRET'],
    },
    'analytics' => {
      'google' => ENV['GOOGLE_ANALYTICS_KEY'],
    },
    'sendgrid' => {
      'username' => ENV['SENDGRID_USERNAME'],
      'password' => ENV['SENDGRID_PASSWORD'],
      'domain' => ENV['SENDGRID_DOMAIN']
    }, 
    'gmail' => {
      'user_name' => ENV["GMAIL_USERNAME"],
      'password' => ENV["GMAIL_PASSWORD"] 
    },
    'mandrill' => {
      'username' => ENV["MANDRILL_USERNAME"],
      'api_key' => ENV["MANDRILL_API_KEY"] 
    },
    'mailchimp' => {
      'username' => ENV["MAILCHIMP_USERNAME"],
      'api_key' => ENV["MAILCHIMP_API_KEY"] 
    }
  }

  APP_CONFIG.merge! env_config
end


