module Cms
  module Generators
    module Component
      class EditingGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        SUPPORTED_EDITORS = %w(redactor)

        class_option :editor,
          type: :string,
          default: SUPPORTED_EDITORS.first,
          desc: "Select what html editor to use. (#{SUPPORTED_EDITORS.join(' | ')})"

        def validate_editor
          unless SUPPORTED_EDITORS.include?(editor)
            puts 'Please choose a supported editor. See options for more details.'
            puts

            self.class.help(self)

            exit
          end
        end

        def create_common_files
          directory('app')
        end

        def run_generator_for_selected_editor
          Rails::Generators.invoke("cms:component:editing:#{editor}", [], behavior: behavior)
        end

        private

        def editor
          options[:editor]
        end
      end
    end
  end
end
