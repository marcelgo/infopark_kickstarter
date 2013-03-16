module Cms
  module Generators
    module Actions
      def turn_model_into_page(class_name)
        file_name = "#{class_name.underscore}.rb"

        gsub_file(
          "app/models/#{file_name}",
          '# include Page',
          'include Page'
        )
      end

      def turn_model_into_box(class_name)
        file_name = "#{class_name.underscore}.rb"

        gsub_file(
          "app/models/#{file_name}",
          '# include Box',
          'include Box'
        )
      end
    end
  end
end