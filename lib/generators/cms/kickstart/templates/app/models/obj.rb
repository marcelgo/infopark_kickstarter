require './lib/rails_connector/cms_attributes'

# This class represents the base class of all CMS objects and implements behavior that all CMS
# objects, regardless whether they are pages, boxes or resources have in common.
class Obj < ::RailsConnector::BasicObj
  include RailsConnector::CmsAttributes

  def self.homepage
    default_homepage
  end

  def self.default_homepage
    Homepage.for_hostname('default')
  end

  def parent
    @parent ||= super()
  end

  def homepage
    @homepage ||= parent.homepage
  end

  def homepages
    website.homepages
  end

  def website
    @website ||= homepage.website
  end

  # Overriden method +slug+ from +RailsConnector::BasicObj+.
  def slug
    (self[:headline] || '').parameterize
  end

  # Return a page object or nil.
  #
  # Normally, objects are either pages, boxes, or media files/resources.
  # Pages are pages in itself, Widgets are treated differently. Media files
  # and resources are filtered out.
  #
  # This method can be overridden by subclasses to implement this behaviour.
  def page
    nil
  end

  def locale
    (homepage && homepage.locale) || I18n.default_locale
  end

  def menu_title
    self[:headline] || self.name
  end

  # Overrides RailsConnector::BasicObj#body_data_url
  #
  # Changes protocol http: to https: so that the URLs work fine with pages delivered over https.
  def body_data_url
    url = super

    if url.to_s =~ /^http:(.*?s3\.amazonaws\.com.*)$/
      "https:#{$1}"
    else
      url
    end
  end
end