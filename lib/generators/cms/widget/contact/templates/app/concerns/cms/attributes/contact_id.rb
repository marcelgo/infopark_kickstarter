module Cms
  module Attributes
    module ContactId
      def contact_id
        self[:contact_id].to_s
      end
    end
  end
end