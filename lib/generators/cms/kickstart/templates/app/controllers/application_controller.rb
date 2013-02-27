class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter Filters::Https
  before_filter Filters::EnvironmentDetection
  before_filter Filters::WorkspaceSelection

  include ExceptionHandling
  include I18nSupport
  include AuthenticationSupport
end