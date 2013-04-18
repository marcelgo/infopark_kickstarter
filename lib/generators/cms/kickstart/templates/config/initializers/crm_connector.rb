require 'infopark_crm_connector'

Infopark::Crm.configure do |config|
  config.url = Rails.application.config.cloud['crm']['url']
  config.login = Rails.application.config.cloud['crm']['login']
  config.api_key = Rails.application.config.cloud['crm']['api_key']
  config.http_host = Rails.application.config.cloud['crm']['http_host']
end