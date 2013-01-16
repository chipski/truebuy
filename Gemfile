source 'https://rubygems.org'
ruby "1.9.3"

gem "i18n"
gem "psych", ">=1.3"          
gem 'rails', '3.2.11'
 
gem 'bundler', ">1.2"
gem 'mysql', '2.8.1' 
gem 'pg', :group => :production  
#gem 'mysql2'
#gem 'sqlite3'
gem 'squeel'  #http://railscasts.com/episodes/354-squeel?view=asciicast
gem "ransack"  #:git => "git://github.com/ernie/ransack.git" # better search gem

gem 'rack'  #, '~> 1.2.1'
gem "rake", "10.0.3"     
gem 'capistrano'
#gem "chronic"
gem "airbrake"

gem "devise", ">= 2.1.2"
gem "cancan", ">= 1.6.8"
gem "rolify", ">= 3.2.0"
gem 'bcrypt-ruby', '~> 3.0.0' 
# Authentication
#gem 'omniauth', '~> 1.0.1'
#gem 'omniauth-dropbox'

gem "haml", ">= 3.1.7"             

gem "less"
gem 'less-rails'
       
gem 'sass-rails',   '~> 3.2.3'
gem "bootstrap-sass"   # should be at 2.2.2.0 now
# need to choose!  use above two or below two gems, not both or a mix
# http://rubysource.com/twitter-bootstrap-less-and-sass-understanding-your-options-for-rails-3-1/
#gem "less-rails-bootstrap"    #this can be switched with gem below but css & js load files will need rework
gem "twitter-bootstrap-rails"                   


group :assets do
  gem 'coffee-rails', '~> 3.2.1' 
  
  gem "libv8"
  gem 'therubyracer', '0.9.10'
  
  gem "font-awesome-sass-rails"
  gem 'uglifier', '>= 1.0.3'
end

#gem 'twitter_bootstrap_form_for'
gem "simple_form", ">= 2.0.4"          
gem "nested_form", :git => "git://github.com/ryanb/nested_form.git"       
gem 'bootstrap-wysihtml5-rails'

#gem "has_scope"
gem 'inherited_resources' 
gem "responders"    
gem 'will_paginate', '~> 3.0'  

gem 'jquery-rails'
gem "jquery-datatables-rails", ">= 1.11.2"

#gem "ember-rails"
#gem "underscore-rails"

#gem "rest-client"
gem 'aasm'              
#gem "stateflow"   
#    
#gem 'acts-as-taggable-on', '~>2.3.1' 
gem "gritter"
gem 'masonry-rails'

gem 'google-analytics-rails'
gem "google_visualr", ">= 2.1.2"  

# Connector to cloud services
gem "fog"
gem "hominid", ">= 3.0.5"
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

group :development do
  #gem 'app_drone' 
  gem "haml-rails", ">= 0.3.5"   
  
  
  gem "ruby_parser", ">= 3.0.1"    
  gem "nifty-generators", ">= 0.4.6"   
  gem 'sexp_processor', '~> 4.1'
  #gem "bootstrapped", :git => 'https://github.com/entropillc/bootstrapped.git'           
  #gem 'nice_generators'
  gem "quiet_assets", ">= 1.0.1"
  gem "erd"
  gem "rails-erd"      
end
 
group :production do
  gem "thin" 
  #gem "unicorn"
end  

