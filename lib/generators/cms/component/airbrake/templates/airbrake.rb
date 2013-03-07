configuration = YAML.load_file(Rails.root + 'config/custom_cloud.yml')

Airbrake.configure do |config|
  config.api_key = configuration['airbrake']['api_key']
  config.secure = true
end