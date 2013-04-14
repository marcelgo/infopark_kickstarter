module Cms
  module Attributes
    # This is a string attribute concern. It should be included via
    # +include Cms::Attributes::Author+
    # in all CMS models that use this attribute.
    module Author
      def author
        author = self[:author] || ''

        if author.present?
          @author ||= Infopark::Crm::Contact.search(params: { login: author }).first
          @author ||= Infopark::Crm::Contact.search(params: { email: author }).first
        end
      end
    end
  end
end