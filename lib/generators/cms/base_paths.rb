module Cms
  module Generators
    module BasePaths
      def website_path
        '/website'
      end

      def resources_path
        '/resources'
      end

      def homepage_path
        "#{website_path}/en"
      end

      def configuration_path
        "#{homepage_path}/_configuration"
      end

      def widgets_path
        "#{homepage_path}/_boxes"
      end
    end
  end
end