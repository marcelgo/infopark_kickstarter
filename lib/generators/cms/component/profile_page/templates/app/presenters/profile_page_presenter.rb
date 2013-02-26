class ProfilePagePresenter
  include ActiveAttr::Model

  attr_reader :user

  attribute :user_id
  attribute :country
  attribute :email
  attribute :first_name
  attribute :gender
  attribute :job_title
  attribute :language
  attribute :last_name
  attribute :city
  attribute :mobile_phone
  attribute :company
  attribute :phone
  attribute :postalcode
  attribute :street_address
  attribute :want_email

  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, email: { message: I18n.t('activemodel.errors.messages.invalid_email') }

  def initialize(user, attributes = {})
    @user = user
    attributes ||= {}

    prefill!(user, attributes)

    super(attributes)
  end

  def save
    if valid?
      save_contact
    end
  end

private

  def save_contact
    attributes.each do |key, value|
      if user.attributes.include?(key)
        user[key] = value
      end
    end

    user.save
  end

  def prefill!(user, attributes)
    attributes['user_id'] = user.id
    attributes.reverse_merge!(user.attributes)
  end
end