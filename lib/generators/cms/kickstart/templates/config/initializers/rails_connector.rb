RailsConnector::Configuration.choose_homepage do |env|
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