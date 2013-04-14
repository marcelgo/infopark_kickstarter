# This class represents the base class of all CMS objects and implements behavior that all CMS
# objects, regardless whether they are pages, boxes or resources have in common.
class Obj < ::RailsConnector::BasicObj
  include Cms::Attributes::SortKey
  include Cms::Attributes::ShowInNavigation

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

  def main_nav_item
    parent.main_nav_item
  end

  def sorted_toclist
    toclist.sort_by { |obj| obj.sort_key.to_s }
  end

  def boxes
    boxes_dir = Obj.find_by_path(path + '/_boxes')

    if boxes_dir.present?
      boxes_dir.sorted_toclist.select { |box| Box === box }
    else
      []
    end
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