Airbrake.configure do |config|
  config.api_key = Rails.application.config.cloud['airbrake']['api_key']
end