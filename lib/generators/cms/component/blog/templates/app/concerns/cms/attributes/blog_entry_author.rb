module Cms
  module Attributes
    # This is a string attribute concern. It should be included via
    # +include Cms::Attributes::BlogEntryAuthor+
    # in all CMS models that use this attribute.
    module BlogEntryAuthor
      def author
        author = self[:blog_entry_author] || ''

        if author.present?
          @author ||= Infopark::Crm::Contact.search(params: { login: author }).first
          @author ||= Infopark::Crm::Contact.search(params: { email: author }).first
        end
      end
    end
  end
end