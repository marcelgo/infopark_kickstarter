module Cms
  module Generators
    module Component
      class SocialSharingGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        class_option :example,
          type: :boolean,
          default: false,
          desc: 'Create an example in the main application layout.'

        def copy_app_directory
          directory('app', force: true)
        end

        def insert_share_code
          return unless example?

          file = 'app/views/layouts/application.html.haml'
          insert_point = "      = render_cell(:footer, :show)"

          data = []

          data << "      = render_cell(:social_sharing, :show, cms_url(@obj))"
          data << "\n"

          data = data.join("\n")

          insert_into_file(file, data, before: insert_point)
        end

        private

        def example?
          options[:example]
        end
      end
    end
  end
end