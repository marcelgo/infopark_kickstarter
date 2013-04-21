module Cms
  module Generators
    module Component
      class LanguageSwitchGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        class_option :example,
          type: :boolean,
          default: false,
          desc: 'Create an example in the main application layout.'

        def copy_app_directory
          directory('app')
          directory('config')
        end

        def extend_homepage
          return unless example?

          file = 'app/views/layouts/application.html.haml'
          insert_point = "            = render_cell(:meta_navigation, :show, @obj, current_user)\n"

          data = []

          data << ''
          data << '            = render_cell(:language_switch, :show, @obj.homepages, @obj.homepage)'
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        private

        def example?
          options[:example]
        end
      end
    end
  end
end