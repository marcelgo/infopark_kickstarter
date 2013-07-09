module Cms
  module Generators
    class DuplicateResourceError < StandardError
    end

    module Migration
      def self.included(base)
        base.send(:include, ::Rails::Generators::Migration)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def next_migration_number(dirname)
          migration_paths = Dir.glob([
            Rails.root + 'cms/migrate',
            Rails.root + 'app/widgets/**/migrate/',
          ])

          ids = migration_paths.inject([]) do |ids, dirname|
            ids << current_migration_number(dirname)
          end

          timestamp = [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d"].max.to_i
          max = ids.max.to_i

          while max >= timestamp do
            timestamp += 1
          end

          timestamp
        end
      end

      private

      def validate_obj_class(name)
        if obj_class_exists?(name)
          error = DuplicateResourceError.new("CMS object class '#{name}' already exists.")

          say_status(:exist, error.message, :blue)

          raise error
        end
      end

      def obj_class_exists?(name)
        revision_id = workspace.revision_id
        endpoint = "revisions/#{revision_id}/obj_classes/#{name}"

        ::RailsConnector::CmsRestApi.get(endpoint).present?
      rescue ::RailsConnector::ClientError
        false
      end

      def workspace
        ::RailsConnector::Workspace.current
      end
    end
  end
end