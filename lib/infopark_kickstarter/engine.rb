module InfoparkKickstarter
  class Engine < ::Rails::Engine
    isolate_namespace InfoparkKickstarter

    config.generators do |generator|
      generator.test_framework :rspec, fixture: false
    end
  end
end
