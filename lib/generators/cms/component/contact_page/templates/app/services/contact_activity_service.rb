class ContactActivityService
  attr_reader :attributes
  attr_reader :kind

  def initialize(attributes, kind)
    @attributes = attributes.symbolize_keys
    @kind = kind
  end

  def submit
    Infopark::Crm::Activity.create(activity_attributes)
  end

  private

  def activity_attributes
    mapping.inject({}) do |params, (from, to)|
      params[to] = send(from)

      params
    end
  end

  def mapping
    {
      subject: :title,
      kind: :kind,
      state: :state,
      name: :custom_name,
      email: :custom_email,
      message: :custom_message,
    }
  end

  def name
    attributes[:name]
  end

  def subject
    attributes[:subject]
  end

  def email
    attributes[:email]
  end

  def message
    attributes[:message]
  end

  def state
    'open'
  end
end