module Cms
  module Generators
    module Component
      class ShareGenerator < ::Rails::Generators::Base
        include Actions

        source_root File.expand_path('../templates', __FILE__)

        def copy_app_directory
          directory('app', force: true)
        end

        def insert_share_code
          file = 'app/views/layouts/application.html.haml'
          insert_point = "            = yield"

          data = []

          data << "\n"
          data << "            = render_cell(:share, :show, cms_url(@obj))"

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end
      end
    end
  end
end