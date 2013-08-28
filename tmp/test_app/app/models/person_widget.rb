class PersonWidget < Obj
  cms_attribute :person, type: :string

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  # include Page
  include Widget

  # Overrides auto-generated method +person+ from +CmsAttributes+.
  def person
    person = self[:person] || ''

    if person.present?
      @person ||= Infopark::Crm::Contact.search(params: { login: person }).first
      @person ||= Infopark::Crm::Contact.search(params: { email: person }).first
    end
  end
end