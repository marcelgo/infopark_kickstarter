RailsConnector::Configuration.instance_name = :default

RailsConnector::Configuration.choose_homepage do |env|
  Homepage.for_hostname(Rack::Request.new(env).host)
end

RailsConnector::Configuration.editing_auth do |env|
  request = Rack::Request.new(env)

  # for simplicity just return true. NEVER EVER USE THIS IN PRODUCTION!!!
  true
end