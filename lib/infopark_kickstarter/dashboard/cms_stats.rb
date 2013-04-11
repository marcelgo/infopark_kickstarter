module InfoparkKickstarter
  module Dashboard
    class CmsStats
      attr_reader :published_objects
      attr_reader :websites
      attr_reader :homepages
      attr_reader :resources
      attr_reader :widgets
      attr_reader :recently_published

      def initialize
        published_workspace.as_current do
          @published_objects = Obj.all.size
          @websites = Obj.where(:_obj_class, :equals, 'Website').size
          @homepages = Obj.where(:_obj_class, :equals, 'Homepage').size
          @resources = Obj.where(:_path, :starts_with, '/resources').and_not(:_obj_class, :equals, 'Container').size
          @widgets = Obj.where(:_obj_class, :contains_prefix, 'Widget').size
          @recently_published = Obj.all.order(:_last_changed).reverse_order.take(20)
        end
      end

      def workspaces
        @workspaces ||= RailsConnector::CmsRestApi.get('workspaces')['results'].size
      end

      private

      def published_workspace
        RailsConnector::Workspace.find('published')
      end
    end
  end
end