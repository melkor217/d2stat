json.array!(@additional_units) do |additional_unit|
  json.extract! additional_unit, :id, :unitname, :item_0, :item_1, :item_2, :item_3, :item_4, :item_5
  json.url additional_unit_url(additional_unit, format: :json)
end
