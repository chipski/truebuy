source 'https://rubygems.org'

gem "i18n"
gem 'pg' #, :group => :production  
#gem 'mysql', '2.8.1' 
#gem 'mysql2'
#gem 'sqlite3' , :group => :development 
gem 'squeel'  #http://railscasts.com/episodes/354-squeel?view=asciicast
gem "ransack"  #:git => "git://github.com/ernie/ransack.git" # better search gem

gem 'rack'          #, '~> 1.2.1'
gem 'rack-rewrite', '~> 1.2.1'
gem "rake"          #, "10.0.3"     
gem "thor"          #, "~> 0.16.0"
gem "haml"          #, ">= 3.1.7"    

gem 'rails', '4.1.5'
gem "protected_attributes"
# gem 'activeresource', github: 'rails/activeresource'
# gem 'actionpack-action_caching', github: 'rails/actionpack-action_caching'
# gem 'actionpack-page_caching', github: 'rails/actionpack-page_caching'
# gem 'activerecord-session_store'
# gem 'rails-observers'
# gem 'actionview-encoded_mail_to'
# gem 'rails-perftest'
# gem 'actionpack-xml_parser', github: 'rails/actionpack-xml_parser' 

# Authentication
gem 'bcrypt', '~> 3.1.7'
#gem "devise-encryptable"   # failing now, todo fix
gem "devise"
gem "cancan"                #, ">= 1.6.8"
gem "rolify"                #, ">= 3.2.0"
gem 'omniauth'
gem 'omniauth-facebook'
gem "koala"  # This is a Graph client for Facebook, still use omniauth to connect
#gem 'omniauth-dropbox'
gem 'oauth2'

#gem "has_scope"
gem 'inherited_resources' 
gem "responders"    
gem 'will_paginate', '~> 3.0'  
gem 'aasm'              
gem 'letsrate'         #https://github.com/muratguzel/letsrate
gem "gritter"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

#gem "stateflow"   
#gem 'acts-as-taggable-on', '~>2.3.1' 
#gem "rest-client"
       
group :assets do
  gem 'uglifier'        , '>= 1.3.0'
  gem 'coffee-rails'    , '~> 4.0.0'
  #gem "libv8"
  gem 'therubyracer' 
  gem 'jquery-rails'
  gem 'turbolinks'
  gem 'bootstrap-sass'  , '~> 3.3.0'
  gem 'sass-rails'      , '~> 4.0.3'
  #gem "font-awesome-sass-rails"
end

#gem 'twitter_bootstrap_form_for'
gem "simple_form", ">= 2.0.4"          
gem "nested_form", :git => "git://github.com/ryanb/nested_form.git"       
gem 'bootstrap-wysihtml5-rails'
gem 'masonry-rails'

gem "jquery-datatables-rails", ">= 1.11.2"
#gem "ember-rails"
#gem "underscore-rails"

gem 'google-analytics-rails'
gem "google_visualr", ">= 2.1.2"  

# Connector to cloud services
gem "fog"
gem "geocoder"    #http://www.rubygeocoder.com/
gem "hominid", ">= 3.0.5"

#gem 'mailjet'   #email out & newsletters
#gem 'airbrake'
#gem 'mixpanel'   # https://github.com/zevarito/mixpanel

# Image Processing and image/file upload    
#gem "remotipart"
#gem "paperclip", '2.4.5'      
#gem 'rack-cache', :require => 'rack/cache'
#gem 'dragonfly', '~>0.9.12'     #https://github.com/markevans/dragonfly
#gem 'dragonfly-rails', :require => 'dragonfly_rails', :git => 'https://github.com/ritxi/dragonfly-rails.git'
gem "mime-types"
gem 'carrierwave'    
gem "jquery-fileupload-rails"
gem 'rmagick'

group :development, :test do
  #gem 'eventmachine', '~> 1.0.0.beta.4.1'
  gem "thin"     
  gem "hpricot", ">= 0.8.6"
  gem "rspec-rails", ">= 2.11.4"
  gem "database_cleaner", ">= 0.9.1"
  gem "email_spec", ">= 1.4.0"             
  gem "letter_opener"
  gem "factory_girl_rails", ">= 4.1.0" 
end

group :test do
  gem "cucumber-rails", ">= 1.3.0"   
  gem "launchy", ">= 2.1.2"   
  gem "capybara", ">= 1.1.3"   
  gem "mocha"
end

#gem 'capistrano'
#gem "chronic"
#gem "airbrake"

group :development do
  #gem 'app_drone' 
  gem "haml-rails", ">= 0.3.5"   
  gem "ruby_parser", ">= 3.0.1"    
  gem "nifty-generators", ">= 0.4.6"   
  gem 'sexp_processor', '~> 4.1'
  #gem "bootstrapped", :git => 'https://github.com/entropillc/bootstrapped.git'           
  #gem 'nice_generators'
  gem "quiet_assets", ">= 1.0.1"
  gem 'spring'  # https://github.com/rails/spring
  gem "erd"
  gem "rails-erd"      
end
 
group :production do
  #gem "thin" 
  #gem "unicorn"
end  

