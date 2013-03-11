class BoxContact < Obj
  include Cms::Attributes::ContactId
  include Cms::Attributes::SortKey
  include Box

  def contact
    @contact ||= Infopark::Crm::Contact.find(contact_id)
  rescue ActiveResource::ResourceNotFound
    raise UserNotFound.new
  end
end