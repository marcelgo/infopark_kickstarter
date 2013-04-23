class FormPresenter
  include ActiveAttr::Model

  attribute :id
  attribute :kind
  attribute :name
  attribute :title
  attribute :state

  def initialize(kind, params)
    self.kind = kind

    create_attributes
    prefill(params)
  end

  def prefill(params)
    params ||= {}

    params.each do |name, value|
      self.send("#{name}=", value)
    end
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
    service.definition
  end

  private

  def create_attributes
    service.custom_attributes.each do |value|
      self.class.attribute value
    end

    self.id = definition.id
    self.name = definition.name
    self.state = definition.states.first
  end
end