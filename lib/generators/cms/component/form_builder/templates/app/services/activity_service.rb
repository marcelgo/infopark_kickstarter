class ActivityService
  include ActiveModel::Validations

  attr_reader :kind
  attr_accessor :attributes

  def initialize(kind)
    @kind = kind
  end

  def definition
    @definition ||= Infopark::Crm::CustomType.find(kind)
  end

  def custom_attributes
    @custom_attributes ||= definition.attributes[:custom_attributes].map(&:name)
  end

  def submit
    activity_attributes = attributes.inject({}) do |hash, (key, value)|
      if custom_attributes.include?(key)
        key = "custom_#{key}"
      end

      hash[key] = value

      hash
    end

    activity = Infopark::Crm::Activity.create(activity_attributes)

    map_errors(activity.errors)
  end

  private

  def map_errors(values)
    values.each do |key, value|
      if key.to_s.starts_with?('custom_')
        key = key.to_s.sub('custom_', '')
        errors.delete(key.to_sym)
      end

      errors.add(key, value)
    end
  end
end