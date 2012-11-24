#CarrierWave.configure do |config|
#  config.fog_credentials = {
#    :provider => 'AWS',
#    :aws_access_key_id => APP_CONFIG['aws']['access_key'],
#    :aws_secret_access_key => APP_CONFIG['aws']['secret_key']
#  }
#  config.fog_directory = APP_CONFIG['aws']['bucket']
#  config.fog_public = true
#  if Rails.env.test?
#    config.storage = :file
#  else
#    config.storage = :fog
#  end
#end