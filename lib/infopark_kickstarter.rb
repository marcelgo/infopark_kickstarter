require 'rails/generators'
require 'net/http'
require 'infopark_rails_connector'

require 'infopark_kickstarter/engine'

require 'generators/cms/migration'
require 'generators/cms/base_paths'
require 'generators/cms/base_attributes'
require 'generators/cms/actions'
require 'generators/cms/model/api/api_generator'
require 'generators/cms/widget/example'
require 'generators/cms/widget/api/api_generator'

module InfoparkKickstarter
  extend ActiveSupport::Autoload

  autoload :Resource
  autoload :Attribute
  autoload :ObjClass
end

configuration = YAML.load_file(InfoparkKickstarter::Engine.root + 'config/rails_connector.yml')

RailsConnector::Configuration.content_service_url = configuration['content_service']['url']
RailsConnector::Configuration.content_service_login = configuration['content_service']['login']
RailsConnector::Configuration.content_service_api_key = configuration['content_service']['api_key']

RailsConnector::Configuration.cms_url = configuration['cms_api']['url']
RailsConnector::Configuration.cms_login = configuration['cms_api']['login']
RailsConnector::Configuration.cms_api_key = configuration['cms_api']['api_key']
