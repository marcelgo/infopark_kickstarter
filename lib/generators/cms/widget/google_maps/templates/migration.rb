class CreateGoogleMaps < ::RailsConnector::Migrations::Migration
  def up
    create_attributes
    create_obj_classes
  end

  private

  def create_attributes
    create_attribute(
      name: '<%= address_attribute_name %>',
      title: 'Address',
      type: :string
    )

    create_attribute(
      name: '<%= map_type_attribute_name %>',
      title: 'Map Typ',
      type: :enum,
      values: [
        'ROADMAP',
        'SATELLITE',
        'HYBRID',
        'TERRAIN',
      ]
    )
  end

  def create_obj_classes
    params = {
      name: '<%= pin_class_name %>',
      title: 'GoogleMaps: Pin',
      type: :publication,
      attributes: [
        '<%= address_attribute_name %>',
      ]
    }

    create_obj_class(params)

    create_obj_class(
      name: '<%= map_class_name %>',
      title: 'Box: GoogleMaps',
      type: :publication,
      attributes: [
        '<%= map_type_attribute_name %>',
        '<%= address_attribute_name %>',
      ],
      preset_attributes: {
        '<%= map_type_attribute_name %>' => 'ROADMAP',
      }
    )
  end
end