json.dashboard do 
  json.array! @dashboard do |heading|
    json.characteristic_id heading.characteristic_id
    json.order heading.order
    json.header_title heading.characteristic.attribute_view_name
    json.column_name heading.characteristic.attribute_column_name
    json.visible heading.visible
  end   
end