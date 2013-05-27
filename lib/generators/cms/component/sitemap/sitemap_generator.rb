module Cms
  module Generators
    module Component
      class SitemapGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def copy_app_directory
          directory('app')
        end

        def add_route
          route "get 'sitemap.xml', controller: 'sitemap', action: 'index', format: 'xml'"
        end
      end
    end
  end
end