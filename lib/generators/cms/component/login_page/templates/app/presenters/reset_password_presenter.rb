class ResetPasswordPresenter
  include ActiveAttr::BasicModel
  include ActiveAttr::MassAssignment

  attr_accessor :login

  validates :login, presence: true

  def find_contact
    contact = Infopark::Crm::Contact.search(params: {login: login}).first

    return contact
  end
end