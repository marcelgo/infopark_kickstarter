module InfoparkKickstarter
  module Dashboard
    class Attribute < Resource
      def self.namespace
        'attributes'
      end

      attr_accessor :id
      attr_accessor :name
      attr_accessor :type
      attr_accessor :values
      attr_accessor :title
      attr_accessor :min_size
      attr_accessor :max_size

      def title?
        title.present?
      end

      def values?
        values.present?
      end

      def min_size?
        min_size.present?
      end

      def max_size?
        max_size.present?
      end
    end
  end
end