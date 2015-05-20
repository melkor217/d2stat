json.array!(@mqueues) do |mqueue|
  json.extract! mqueue, :id, :match_id
  json.url mqueue_url(mqueue, format: :json)
end
