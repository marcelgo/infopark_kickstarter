module Cms
  module Generators
    module Component
      class SocialSharingGenerator < ::Rails::Generators::Base
        include Actions

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

          file = Rails.root + 'app/views/layouts/application.html.haml'

          if File.exists?(file)
            insert_point = "            = yield"

            data = []

            data << "\n"
            data << "            = render_cell(:social_sharing, :show, cms_url(@obj))"

            data = data.join("\n")

            insert_into_file(file, data, after: insert_point)
          end
        end

        private

        def example?
          options[:example]
        end
      end
    end
  end
end