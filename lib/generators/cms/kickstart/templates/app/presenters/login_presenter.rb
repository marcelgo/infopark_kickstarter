class LoginPresenter
  include ActiveAttr::BasicModel
  include ActiveAttr::MassAssignment

  attr_accessor :login
  attr_accessor :password

  validates :login, presence: true
  validates :password, presence: true

  def authenticate
    contact = Infopark::Crm::Contact.authenticate(login, password)

    User.new(contact.attributes)
  rescue Infopark::Crm::Errors::AuthenticationFailed, ActiveResource::ResourceInvalid
    errors.add(:base, I18n.t(:'simple_form.error_notification.login_presenter'))

    nil
  end
end