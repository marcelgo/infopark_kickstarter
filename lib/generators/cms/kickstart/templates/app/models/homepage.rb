class Homepage < Obj
  include Cms::Attributes::Headline
  include Cms::Attributes::ErrorNotFoundPageLink
  include Cms::Attributes::LoginPageLink
  include Cms::Attributes::Locale
  include Cms::Attributes::FooterLinks

  include Page

  # TODO edit mapping from hostnames to homepages
  def self.for_hostname(hostname)
    find_by_path('/website/en')
  end

  # TODO edit mapping from homepages to hostnames
  # Inverse of .for_hostname
  def desired_hostname
    'www.website.com'
  end

  def homepage
    self
  end

  def website
    parent
  end

  def main_nav_item
    nil
  end
end