class ResetPasswordPresenter
  include ActiveAttr::BasicModel
  include ActiveAttr::MassAssignment

  attr_accessor :login

  validates :login, presence: true

  def password_request
    contact = Infopark::Crm::Contact.search(params: { login: login }).first

    if contact
      contact.password_request
    end

    contact
  end
end