# Load the rails application
require File.expand_path('../application', __FILE__)

APP_CONFIG = YAML.load(File.read("#{Rails.root}/config/app_config.yml"))[Rails.env] #.symbolize_keys

# Initialize the rails application
Reviews::Application.initialize!

