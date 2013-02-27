class Homepage < Obj
  include Cms::Attributes::ErrorNotFoundPageLink
  include Cms::Attributes::SearchPageLink
  include Cms::Attributes::LoginPageLink
  include Cms::Attributes::Locale
  include Page

  # TODO edit mapping from hostnames to homepages
  def self.for_hostname(hostname)
    find_by_path(
      case hostname
      when /foo\.com/, /foo-(live|staging)\.infopark\.com/, /foo\.dev/
        '/foo/en'
      else
        # Default homepage
        '<%= homepage_path %>'
      end
    )
  end

  # TODO edit mapping from homepages to hostnames
  # Inverse of #for_hostname
  def desired_hostname
    if path.start_with?('/foo/en')
      Rails.env.staging? ? 'foo-staging.infopark.com' : 'www.foo.com'
    else
      # Default hostname
      Rails.env.staging? ? 'website-staging.infopark.com' : 'www.website.com'
    end
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