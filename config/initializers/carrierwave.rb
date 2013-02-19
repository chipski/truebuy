CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => APP_CONFIG['aws']['access_key'],
    :aws_secret_access_key => APP_CONFIG['aws']['secret_key']
  }
  config.fog_directory = APP_CONFIG['aws']['bucket']
  config.fog_public = false  #ToDo does this mean previews are all public??
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  
  #config.asset_host = "http://c000000.cdn.rackspacecloud.com"
  
  if Rails.env.test? || Rails.env.dev?
    config.storage = :file
  else
    config.storage = :fog
  end
end