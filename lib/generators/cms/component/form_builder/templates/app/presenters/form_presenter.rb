class FormPresenter
  include ActiveAttr::Model

  attribute :id
  attribute :kind
  attribute :name
  attribute :title
  attribute :state

  def initialize(kind, params)
    self.kind = kind

    prefill(params, service)
  end

  def submit
    service.attributes = attributes
    service.submit

    errors.blank?
  end

  def errors
    service.errors
  end

  def service
    @service ||= ActivityService.new(kind)
  end

  def definition
    @definition ||= service.definition
  end

  private

  def prefill(params, service)
    create_attributes(service)

    params ||= {}
    definition = service.definition

    params.reverse_merge!({
      id: definition.id,
      name: definition.name,
      state: definition.states.first,
    })

    params.each do |name, value|
      self.send("#{name}=", value)
    end
  end

  def create_attributes(service)
    service.custom_attributes.each do |value|
      self.class.attribute value
    end
  end
end