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

  def main_nav_item
  end
end