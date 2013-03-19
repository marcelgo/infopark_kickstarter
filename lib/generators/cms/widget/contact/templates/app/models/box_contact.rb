class BoxContact < Obj
  include Box

  include Cms::Attributes::ContactId
  include Cms::Attributes::SortKey

  def contact
    @contact ||= Infopark::Crm::Contact.find(contact_id)
  rescue ActiveResource::ResourceNotFound
  end
end