module InfoparkKickstarter
  module Dashboard
    class Gem
      def self.all
        %w(infopark_rails_connector infopark_crm_connector infopark_kickstarter rails bundler).map do |name|
          new(name)
        end
      end

      attr_accessor :name

      def initialize(name)
        @name = name
      end

      def rubygems_url
        @rubygems_url ||= "https://rubygems.org/gems/#{name}"
      end

      def version
        @version ||= ::Gem.loaded_specs[name].version
      end

      def latest_version
        @latest_version ||= ::Gem.latest_version_for(name)
      end

      def latest?
        version == latest_version
      end
    end
  end
end