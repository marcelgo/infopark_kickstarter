module InfoparkKickstarter
  class Engine < ::Rails::Engine
    isolate_namespace InfoparkKickstarter

    config.generators do |generator|
      generator.test_framework :rspec, fixture: false
    end

    initializer('infopark_kickstarter.configuration') do |app|
      app.config.infopark_kickstarter = InfoparkKickstarter::Configuration.new
    end
  end
end