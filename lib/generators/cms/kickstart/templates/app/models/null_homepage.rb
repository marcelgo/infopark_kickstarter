# This file is only used to display an introduction page, in case the current
# working copy does not return a valid homepage object. Usually, you can delete
# this file safely once you first published your content. See
# "app/controllers/null_homepage_controller" and
# "config/initializers/rails_connector.rb" as well.
class NullHomepage < Obj
  def controller_name
    'NullHomepage'
  end

  def path
    'null-homepage'
  end

  def object_type
    :publication
  end

  def id
    '0'
  end

  def active?
    true
  end

  def homepage
  end

  def homepages
    []
  end
end