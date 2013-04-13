class ContactPagePresenter
  include ActiveAttr::Model

  attribute :email
  attribute :subject
  attribute :message

  validates :subject, presence: true
  validates :email, presence: true
end