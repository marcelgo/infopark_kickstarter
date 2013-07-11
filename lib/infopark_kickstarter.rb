require 'rails/generators'
require 'jquery-rails'
require 'less-rails-bootstrap'
require 'haml'
require 'infopark_rails_connector'

require 'infopark_kickstarter/engine'
require 'infopark_kickstarter/configuration'
require 'infopark_kickstarter/dashboard'

require 'generators/cms/migration'
require 'generators/cms/base_paths'
require 'generators/cms/base_attributes'
require 'generators/cms/actions'
require 'generators/cms/model/api/api_generator'
require 'generators/cms/widget/example'
require 'generators/cms/widget/api/api_generator'

module InfoparkKickstarter
end