$:.push File.expand_path('../lib', __FILE__)

require 'ice_kickstarter/version'

Gem::Specification.new do |gem|
  gem.platform    = Gem::Platform::RUBY
  gem.name        = 'ice_kickstarter'
  gem.version     = IceKickstarter::VERSION
  gem.summary     = 'Infopark Cloud Express Kickstarter'
  gem.description = 'Infopark Cloud Express Kickstarter'
  gem.has_rdoc    = 'yard'

  gem.required_ruby_version     = Gem::Requirement.new('>= 1.9.3')
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.8.25')

  gem.license = 'LGPLv3'

  gem.authors   = ['Infopark AG']
  gem.email     = ['info@infopark.de']
  gem.homepage  = 'http://www.infopark.de'

  gem.bindir      = 'bin'
  gem.executables = []
  gem.test_files  = Dir['spec/**/*']
  gem.files       = Dir['lib/**/*', 'LICENSE', 'Rakefile', 'README.md', 'CHANGELOG.md']

  gem.add_dependency 'rails', '~> 3.2.12'
  gem.add_dependency 'jquery-rails'
  gem.add_dependency 'haml'
  gem.add_dependency 'less-rails-bootstrap'
  gem.add_dependency 'infopark_rails_connector', '>= 6.8.2.7.128454143'
  gem.add_dependency 'infopark_cloud_connector', '>= 6.8.2.7.128454143'

  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'redcarpet'
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'generator_spec'
end