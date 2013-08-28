module RailsConnector
  module CmsDefinitions
    extend ActiveSupport::Concern

    def cms_attribute_definition(attribute)
      self.class.cms_attribute_definition(attribute)
    end

    module ClassMethods
      def cms_obj_class_definition
        @obj_class_hash ||= begin
          revision_id = RailsConnector::Workspace.current.revision_id

          RailsConnector::CmsRestApi.get("revisions/#{revision_id}/obj_classes/#{name}")
        end
      end

      def cms_attribute_definition(attribute_name)
        obj_class = cms_obj_class_definition

        obj_class['attributes'].detect do |definition|
          definition['name'] == attribute_name.to_s
        end
      end
    end

  end
end