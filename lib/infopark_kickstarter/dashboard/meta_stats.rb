module InfoparkKickstarter
  module Dashboard
    class MetaStats
      def maximum_attributes
        @maximum_attributes ||= max_group_size(grouped_attributes).second.size.to_f
      end

      def grouped_attributes
        @grouped_attributes ||= attributes.group_by(&:type)
      end

      def obj_classes_count
        obj_classes.size
      end

      def obj_classes
        @obj_classes ||= ObjClass.all
      end

      def global_attributes_count
        global_attributes.size
      end

      def global_attributes
        @attributes ||= Attribute.all
      end

      private

      def max_group_size(hash)
        hash.max do |a, b|
          a.second.size <=> b.second.size
        end
      end
    end
  end
end