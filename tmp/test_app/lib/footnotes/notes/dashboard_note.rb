module Footnotes
  module Notes
    class DashboardNote < AbstractNote
      # This method always receives a controller
      #
      def initialize(controller)
        @controller = controller
      end

      # Set href field for Footnotes links.
      # If it's nil, Footnotes will use '#'.
      #
      def link
        InfoparkDashboard::Engine.routes.url_helpers.root_path
      end

      # Returns the title that represents this note.
      #
      def title
        'Dashboard'
      end

      # Specifies in which row should appear the title.
      # The default is :show.
      #
      def row
        :infopark
      end
    end
  end
end