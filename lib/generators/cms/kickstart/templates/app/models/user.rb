class User
  include ActiveAttr::Model

  attribute :id
  attribute :login
  attribute :role_names
  attribute :gender
  attribute :first_name
  attribute :last_name
  attribute :email
  attribute :language
  attribute :want_email

  def cache_attributes
    attributes.slice('id', 'role_names')
  end

  def save
    fetch.update_attributes(attributes)
  end

  def logged_in?
    true
  end

  def admin?
    role_names.include?('cmsadmin')
  end

  def fetch
    Infopark::Crm::Contact.find(id)
  end
end