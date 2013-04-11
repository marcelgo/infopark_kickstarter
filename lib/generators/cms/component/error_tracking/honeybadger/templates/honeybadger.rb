if defined?(Honeybadger)
  configuration = YAML.load_file(Rails.root + 'config/custom_cloud.yml')

  Honeybadger.configure do |config|
    config.api_key = configuration['honeybadger']['api_key']
  end
end