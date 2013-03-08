module InfoparkKickstarter
  module Dashboard
    class Resource
      class << self
        def find(id)
          attributes = Rails.cache.fetch(cache_key(id)) do
            endpoint(id)
          end

          new(attributes)
        end

        def all
          attributes = endpoint['results']

          attributes.map do |attributes|
            new(attributes)
          end
        end

        def cache_key(id)
          "#{namespace}_#{id}_#{revision_id}"
        end

        private

        def namespace
          raise NotImplementedError.new
        end

        def revision_id
          RailsConnector::Workspace.current.revision_id
        end

        def endpoint(path = '')
          RailsConnector::CmsRestApi.get("revisions/#{revision_id}/#{namespace}/#{path}")
        end
      end

      def initialize(attributes = {})
        attributes.each do |key, value|
          send("#{key}=", value)
        end
      end
    end
  end
end