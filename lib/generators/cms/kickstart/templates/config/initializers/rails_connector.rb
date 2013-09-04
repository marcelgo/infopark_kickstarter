configuration = YAML.load_file(Rails.root + 'config/rails_connector.yml')

RailsConnector::Configuration.content_service_url = configuration['content_service']['url']
RailsConnector::Configuration.content_service_login = configuration['content_service']['login']
RailsConnector::Configuration.content_service_api_key = configuration['content_service']['api_key']

RailsConnector::Configuration.cms_url = configuration['cms_api']['url']
RailsConnector::Configuration.cms_login = configuration['cms_api']['login']
RailsConnector::Configuration.cms_api_key = configuration['cms_api']['api_key']

RailsConnector::Configuration.choose_homepage do |env|
  # Returns an introduction page, when no Homepage found. Usually, you can delete
  # the NullHomepage.new fallback once you first published your content. See
  # "app/controllers/null_homepage_controller.rb" and
  # "app/models/null_homepage.rb" as well.
  Homepage.for_hostname(Rack::Request.new(env).host) || NullHomepage.new
end

# This callback is important for security.
#
# It is used to provide inplace editing features. Even if you don't use inplace editing
# on the client side, the server side also uses this callback to determine if CMS data
# can be modified in the database.
RailsConnector::Configuration.editing_auth do |env|
  request = Rack::Request.new(env)
  EditModeDetection.editing_allowed?(request.session)
end
