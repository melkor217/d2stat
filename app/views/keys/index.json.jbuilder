json.array!(@keys) do |key|
  json.extract! key, :id, :name, :value
  json.url key_url(key, format: :json)
end
